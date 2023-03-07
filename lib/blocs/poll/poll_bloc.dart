import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as Models;
import 'package:dart_appwrite/dart_appwrite.dart' as dart_appwrite;
import 'package:bloc/bloc.dart';
import 'package:face_to_face_voting/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'poll_event.dart';
part 'poll_state.dart';
part 'poll_bloc.freezed.dart';

class PollBloc extends Bloc<PollEvent, PollState> {
  final Client client;
  final Account account;
  final Databases databases;
  final Teams teams;
  final Realtime realtime;
  final dart_appwrite.Health health;

  final RealtimeSubscription subscription;
  late DateTime serverTime;
  Timer? timer;

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

  void subscribe(emit) {
    subscription.stream.listen((event) async {
      print('New event: $event, state: $state');
      // Если состояние не успело загрузиться, то ничего не делаем
      if (state.maybeMap(success: (value) => false, orElse: () => true)) {
        return;
      }

      final currentState = state as _Success;

      print('New event: $event');
      final eventAction = event.events.first.split('.').last;

      // Нас интересуют только события, которые могут изменить данные
      if (eventAction != 'create' &&
          eventAction != 'update' &&
          eventAction != 'delete') {
        return;
      }

      print('Event action: $eventAction');

      final doc = Models.Document.fromMap(event.payload);

      if (doc.$collectionId == pollsCollectionId) {
        if (doc.data['event_id'] == currentState.eventId) {
          print('Poll changed');

          serverTime = await _getServerTime();

          final polls = await databases.listDocuments(
            databaseId: databaseId,
            collectionId: pollsCollectionId,
            queries: [
              Query.equal('event_id', currentState.eventId),
              Query.orderDesc('start_at'),
            ],
          );

          final poll = await _getActiveOrLastPoll(polls);

          if (poll == null) {
            emit(const PollState.noPoll());
            return;
          }

          final timeLeft = _calculateTimeLeft(poll);

          emit(PollState.success(
            currentState.eventId,
            poll,
            currentState.votes,
            timeLeft,
          ));

          // Обновляем таймер
          timer?.cancel();
          timer = Timer.periodic(const Duration(seconds: 1), (_) {
            final newTimeLeft = _calculateTimeLeft(poll);
            if (state.maybeMap(
                orElse: () => false,
                success: (state) => state.timeLeft != newTimeLeft)) {
              emit(PollState.success(
                currentState.eventId,
                poll,
                currentState.votes,
                newTimeLeft,
              ));
            }
          });
        }
      }

      if (doc.$collectionId == votesCollectionId) {
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
    });
  }

  PollBloc({
    required this.client,
    required this.account,
    required this.databases,
    required this.teams,
    required this.realtime,
    required this.health,
    required this.subscription,
  }) : super(PollState.initial()) {
    on<_LoadPolls>((event, emit) async {
      emit(PollState.loading());
      final eventId = event.eventId;

      // try {
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

        timer = Timer.periodic(const Duration(seconds: 1), (_) {
          final newTimeLeft = _calculateTimeLeft(poll);
          if (state.maybeMap(
              orElse: () => false,
              success: (state) => state.timeLeft != newTimeLeft)) {
            emit(PollState.success(
              eventId,
              poll,
              votes,
              newTimeLeft,
            ));
          }
        });
      } else {
        emit(const PollState.noPoll());
      }

      subscribe(emit);
      // } catch (error) {
      //   emit(PollState.error(error.toString()));
      // }
    });
  }
}
