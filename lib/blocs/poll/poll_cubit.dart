import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as Models;
import 'package:dart_appwrite/dart_appwrite.dart' as dart_appwrite;
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:face_to_face_voting/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'poll_state.dart';
part 'poll_cubit.freezed.dart';

class PollCubit extends Cubit<PollState> {
  final Client client;
  final Account account;
  final Databases databases;
  final Teams teams;
  final Realtime realtime;
  final dart_appwrite.Health health;

  final Dio clientDio = Dio();

  late DateTime serverTime;
  Timer? timer;
  PollCubit({
    required this.client,
    required this.account,
    required this.databases,
    required this.teams,
    required this.realtime,
    required this.health,
  }) : super(const PollState.initial());

  DateTime get now => DateTime.now().toUtc();

  Future<DateTime> _getServerTime() async {
    final response = await health.getTime();
    final serverTime = response.remoteTime;

    print('Server time: $serverTime');

    return DateTime.fromMillisecondsSinceEpoch(serverTime);
  }

  Future<Models.Document?> _getActiveOrLastPoll(
      Models.DocumentList polls) async {
    if (polls.total > 0) {
      for (final poll in polls.documents) {
        final startAt = DateTime.parse(poll.data['start_at']);
        final endAt = DateTime.parse(poll.data['end_at']);

        if (now.isAfter(startAt) && now.isBefore(endAt)) {
          return poll;
        }
      }

      return polls.documents[0];
    }

    return null;
  }

  Duration _calculateTimeLeft(Models.Document poll) {
    final startAt = DateTime.parse(poll.data['start_at']).toUtc();
    final endAt = DateTime.parse(poll.data['end_at']).toUtc();
    final timeLeft =
        endAt.difference(serverTime.add(now.difference(serverTime)));

    return timeLeft.isNegative ? Duration.zero : timeLeft;
  }

  void loadPolls(String eventId) async {
    emit(const PollState.loading());

    try {
      final polls = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: pollsCollectionId,
        queries: [
          Query.equal('event_id', eventId),
          Query.orderDesc('start_at'),
        ],
      );

      serverTime = await _getServerTime();

      final poll = await _getActiveOrLastPoll(polls);

      if (poll != null) {
        final votes = await databases.listDocuments(
          databaseId: databaseId,
          collectionId: votesCollectionId,
          queries: [Query.equal('poll_id', poll.$id)],
        );

        emit(PollState.success(
          eventId,
          poll,
          votes,
          _calculateTimeLeft(poll),
        ));

        // Создаем таймер для обновления timeLeft каждую секунду
        timer = Timer.periodic(
          const Duration(seconds: 1),
          (_) {
            final newTimeLeft = _calculateTimeLeft(poll);

            if (state is _Success) {
              final state = this.state as _Success;
              if (state.timeLeft != newTimeLeft) {
                emit(PollState.success(
                  eventId,
                  poll,
                  state.votes,
                  newTimeLeft,
                ));
              }
            }
          },
        );
      } else {
        emit(PollState.noPoll(eventId));
      }
    } catch (error) {
      emit(PollState.error(error.toString()));
    }
  }

  void processRealtimeEvent(RealtimeMessage message) async {
    if (state is! _Success && state is! _NoPoll) {
      return;
    }

    final payload = message.payload;
    final doc = Models.Document.fromMap(payload);

    if (doc.$collectionId == pollsCollectionId) {
      serverTime = await _getServerTime();

      late final String eventId;
      if (state is _Success) {
        eventId = (state as _Success).eventId;
      } else {
        eventId = (state as _NoPoll).eventId;
      }

      if (doc.data['event_id'] == eventId) {
        print('Poll changed!');
        final polls = await databases.listDocuments(
          databaseId: databaseId,
          collectionId: pollsCollectionId,
          queries: [
            Query.equal('event_id', eventId),
            Query.orderDesc('start_at'),
          ],
        );

        final poll = await _getActiveOrLastPoll(polls);

        if (poll == null) {
          emit(PollState.noPoll(eventId));
          return;
        }

        late final Models.DocumentList votes;
        if (state is _NoPoll) {
          votes = await databases.listDocuments(
              databaseId: databaseId,
              collectionId: votesCollectionId,
              queries: [Query.equal('poll_id', doc.$id)]);
        } else {
          votes = (state as _Success).votes;
        }

        final timeLeft = _calculateTimeLeft(poll);

        emit(PollState.success(
          eventId,
          poll,
          votes,
          timeLeft,
        ));

        // Обновляем таймер
        timer?.cancel();
        timer = Timer.periodic(
          const Duration(seconds: 1),
          (_) {
            final newTimeLeft = _calculateTimeLeft(poll);
            final state = this.state;

            if (state is _Success) {
              if (state.timeLeft != newTimeLeft) {
                emit(PollState.success(
                  eventId,
                  poll,
                  state.votes,
                  newTimeLeft,
                ));
              }
            }
          },
        );
      }
    }

    if (doc.$collectionId == votesCollectionId) {
      if (state is! _Success) {
        return;
      }

      final currentState = state as _Success;

      final pollId = doc.data['poll_id'];

      if (currentState.poll.$id == pollId) {
        print('Vote changed');

        final votes = await databases.listDocuments(
          databaseId: databaseId,
          collectionId: votesCollectionId,
          queries: [Query.equal('poll_id', pollId)],
        );

        emit(PollState.success(
          currentState.eventId,
          currentState.poll,
          votes,
          currentState.timeLeft,
        ));
      }
    }
  }

  void sendVote(String eventId, String pollId, String vote) async {
    final jwt = await account.createJWT();

    try {
      print(
          'Sending vote: $vote, pollId: $pollId, eventId: $eventId, jwt: $jwt');

      final response = await clientDio.post(
        '$apiUrl/votes/create',
        data: {
          'eventId': eventId,
          'pollId': pollId,
          'vote': vote,
          'jwt': jwt.jwt,
        },
        options: Options(
          headers: {
            'content-type': 'application/json',
          },
        ),
      );

      print(response.data);
    } catch (error) {
      print(error);
    }
  }
}
