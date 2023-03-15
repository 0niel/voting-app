import 'dart:async';
import 'package:collection/collection.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as Models;
import 'package:dart_appwrite/dart_appwrite.dart' as dart_appwrite;
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:face_to_face_voting/constants.dart';
import 'package:face_to_face_voting/data/remote_data.dart';
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

  final RemoteData remoteData;

  late DateTime serverTime;
  Timer? timer;
  PollCubit({
    required this.client,
    required this.account,
    required this.databases,
    required this.teams,
    required this.realtime,
    required this.health,
    required this.remoteData,
  }) : super(const PollState.initial());

  DateTime get now => DateTime.now().toUtc();

  Future<DateTime> _getServerTime() async {
    final response = await health.getTime();
    final serverTime = response.remoteTime;

    print('Server time: $serverTime');

    return DateTime.fromMillisecondsSinceEpoch(serverTime);
  }

  Future<Models.Document?> _getActiveOrLastPoll(
    Models.DocumentList polls,
  ) async {
    if (polls.total == 0) {
      return null;
    }

    polls.documents.sort((a, b) {
      final aStartAt = DateTime.parse(a.data['start_at']);
      final bStartAt = DateTime.parse(b.data['start_at']);

      return bStartAt.compareTo(aStartAt);
    });

    final activePoll = polls.documents.firstWhereOrNull((poll) {
      final startAt = DateTime.parse(poll.data['start_at']);
      final endAt = DateTime.parse(poll.data['end_at']);

      return now.isAfter(startAt) && now.isBefore(endAt);
    });

    return activePoll ?? polls.documents.first;
  }

  Duration _calculateTimeLeft(Models.Document poll) {
    final startAt = DateTime.parse(poll.data['start_at']).toUtc();
    final endAt = DateTime.parse(poll.data['end_at']).toUtc();
    final timeLeft =
        endAt.difference(serverTime.add(now.difference(serverTime)));

    return timeLeft.isNegative ? Duration.zero : timeLeft;
  }

  double _calculatePercentsLeft(Models.Document poll) {
    final endAt = DateTime.parse(poll.data['end_at']).toUtc();

    final percentsLeft = (serverTime.difference(endAt).inSeconds / 60) * -100;

    return percentsLeft.clamp(0.0, 100.0);
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
      if (poll == null) {
        emit(PollState.noPoll(eventId));
        return;
      }

      final votes = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: votesCollectionId,
        queries: [Query.equal('poll_id', poll.$id), Query.limit(300)],
      );

      emit(PollState.success(
        eventId,
        poll,
        votes,
        _calculateTimeLeft(poll),
        _calculatePercentsLeft(poll),
      ));

      timer?.cancel();
      // Создаем таймер для обновления timeLeft каждую секунду
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) {
          final newTimeLeft = _calculateTimeLeft(poll);
          final state = this.state;

          if (state is _Success && state.timeLeft != newTimeLeft) {
            emit(PollState.success(
              eventId,
              poll,
              state.votes,
              _calculateTimeLeft(poll),
              _calculatePercentsLeft(poll),
            ));
          }
        },
      );
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

      if (doc.data['event_id'] != eventId) {
        return;
      }

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
      // Мероприяте активно, но нет голосования
      if (poll == null) {
        emit(PollState.noPoll(eventId));
        return;
      }

      late final Models.DocumentList votes;
      if (state is _NoPoll) {
        votes = await databases.listDocuments(
            databaseId: databaseId,
            collectionId: votesCollectionId,
            queries: [Query.equal('poll_id', doc.$id), Query.limit(300)]);
      } else {
        // Не обновляем голоса при изменении голосования, иначе будет мерцание
        votes = (state as _Success).votes;
      }

      final timeLeft = _calculateTimeLeft(poll);
      final currentState = state;

      if (currentState is! _Success) {
        return;
      }

      if (currentState.timeLeft == timeLeft) {
        return;
      }

      emit(PollState.success(
        eventId,
        poll,
        votes,
        timeLeft,
        _calculatePercentsLeft(poll),
      ));

      // Обновляем таймер
      timer?.cancel();
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) {
          final newTimeLeft = _calculateTimeLeft(poll);
          final state = this.state;

          if (state is _Success && state.timeLeft != newTimeLeft) {
            emit(PollState.success(
              eventId,
              poll,
              state.votes,
              newTimeLeft,
              _calculatePercentsLeft(poll),
            ));
          }
        },
      );
    } else if (doc.$collectionId == votesCollectionId) {
      if (state is! _Success) {
        return;
      }

      final currentState = state as _Success;
      final pollId = doc.data['poll_id'];

      if (currentState.poll.$id != pollId) {
        return;
      }

      print('Vote changed');

      final votes = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: votesCollectionId,
        queries: [Query.equal('poll_id', pollId), Query.limit(300)],
      );

      emit(PollState.success(
        currentState.eventId,
        currentState.poll,
        votes,
        currentState.timeLeft,
        _calculatePercentsLeft(currentState.poll),
      ));
    }
  }

  void sendVote(String eventId, String pollId, String vote) async {
    final jwt = await account.createJWT();

    try {
      remoteData.sendVote(eventId, pollId, vote, jwt.jwt);
    } catch (error) {
      emit(PollState.error(error.toString()));
    }
  }
}
