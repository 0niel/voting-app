import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:face_to_face_voting/constants.dart';
import 'package:face_to_face_voting/data/sources/local_storage.dart';
import 'package:face_to_face_voting/utils/formatters.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:appwrite/models.dart' as Models;

import '../../service_locator.dart';
import '../events/events_cubit.dart';
import '../poll/poll_cubit.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  final Client client;
  final Databases databases;
  final Account account;
  final Avatars avatars;
  final Teams teams;
  final LocalStorage localStorage;
  final Realtime realtime;

  RealtimeSubscription? subscription;

  @override
  Future<void> close() async {
    subscription?.close();
    super.close();
  }

  Future<void> subscribeRealtime() async {
    if (subscription != null) {
      return;
    }

    subscription = realtime.subscribe([
      'databases.$databaseId.collections.$eventsCollectionId.documents',
      'databases.$databaseId.collections.$pollsCollectionId.documents',
      'databases.$databaseId.collections.$votesCollectionId.documents',
      'databases.$databaseId.collections.$resourcesCollectionId.documents',
      'memberships',
      'teams',
    ]);

    print('Subscribed to realtime events');

    subscription!.stream.timeout(
      const Duration(seconds: 5),
      onTimeout: (sink) async {
        sink.addError('Realtime subscription timeout');

        try {
          subscription?.close();
        } catch (e) {
          debugPrint('realtime_mixin:onTimeout: ${e.toString()}');
        }
        subscription = null;
        await subscribeRealtime();
      },
    );

    subscription!.stream.listen(
      (event) {
        print("New event: $event recieved");

        final eventAction = event.events.first.split('.').last;
        final eventTarget = event.events.first.split('.').first;

        if (eventAction != 'create' &&
            eventAction != 'update' &&
            eventAction != 'delete') {
          return;
        }

        print('Event action: $eventAction');

        if (eventTarget == 'teams' || eventTarget == 'memberships') {
          // Возможно, что пользователя удалили или добавили в список участников
          // Поэтому нужно обновить список событий
          getIt<EventsCubit>().loadEventsList();
        } else {
          final doc = Models.Document.fromMap(event.payload);

          if (doc.$collectionId == eventsCollectionId) {
            getIt<EventsCubit>().processRealtimeEvent(event);
          } else if (doc.$collectionId == pollsCollectionId ||
              doc.$collectionId == votesCollectionId) {
            getIt<PollCubit>().processRealtimeEvent(event);
          } else if (doc.$collectionId == resourcesCollectionId) {
            getIt<EventsCubit>().processRealtimeEvent(event);
          }
        }
      },
      onError: (err, st) =>
          debugPrint('realtime_mixin:onError: ${err.toString()}'),
      onDone: () async {
        debugPrint('realtime_mixin:onDone');
        // Переподписываемся на события
        try {
          subscription?.close();
        } catch (e) {
          debugPrint('realtime_mixin:onDone: ${e.toString()}');
        }
        subscription = null;
        await subscribeRealtime();
        debugPrint('realtime_mixin:onDone: re-subscribed');
      },
      cancelOnError: false,
    );
  }

  String _mapErrorsToMessage(String? error) {
    if (error == null) {
      return 'Неизвестная ошибка';
    }

    if (error.contains('Value must be a valid email address')) {
      return 'Неверный формат электронной почты';
    } else if (error.contains('Password must be at least 8 characters')) {
      return 'Пароль должен быть не менее 8 символов';
    } else if (error.contains('Please check the email and password')) {
      return 'Неверный адрес электронной почты или пароль';
    } else if (error.contains('A user with the same email already exists')) {
      return 'Пользователь с таким адресом электронной почты уже существует.';
    }
    return error;
  }

  UserCubit({
    required this.client,
    required this.account,
    required this.avatars,
    required this.localStorage,
    required this.databases,
    required this.teams,
    required this.realtime,
  }) : super(const _Initial());

  Future<void> _loadUserData() async {
    try {
      final sessions = await account.listSessions();
      for (final session in sessions.sessions) {
        if (session.provider == 'mirea') {
          try {
            final headers = {
              'Authorization': 'Bearer ${session.providerAccessToken}',
            };

            final response = await Dio().get(
                'https://lks.mirea.ninja/api/?action=getData&url=https://lk.mirea.ru/profile/',
                options: Options(headers: headers));

            final data = jsonDecode(response.data);

            final students = data["STUDENTS"].values.where((element) =>
                !element["PROPERTIES"]["PERSONAL_NUMBER"]["VALUE"]
                    .contains("Д") &&
                !element["PROPERTIES"]["PERSONAL_NUMBER"]["VALUE"]
                    .contains("Ж"));

            final studentsList = students.toList();

            final student = students.firstWhere(
                (element) => element['status'] == 'активный',
                orElse: () => students.first);

            await account.updatePrefs(prefs: {
              'id': data["ID"],
              'course': int.parse(student["PROPERTIES"]["COURSE"]["VALUE"]),
              'personalNumber': student["PROPERTIES"]["PERSONAL_NUMBER"]
                  ["VALUE"],
              'academicGroup': student["PROPERTIES"]["ACADEMIC_GROUP"]
                  ["VALUE_TEXT"],
            });
          } catch (e) {
            print(e);
          }
          break;
        }
      }
    } catch (e) {
      print(e);
    }

    final user = await account.get();
    final prefs = await account.getPrefs();

    final avatarByteList = await avatars.getInitials(
      name: StringFormatter.cyryllicToLat(user.name),
    );

    final avatar = Image.memory(avatarByteList);

    final events = await databases.listDocuments(
        databaseId: databaseId, collectionId: eventsCollectionId);
    final eventsList = events.documents;

    // Получение списка команд, в которых мы состоим
    final teamsList = await teams.list();

    // Получение списка events, в которых мы состоим в команде participants_team_id
    final eventsWithMembership = eventsList.where((element) =>
        element.data['participants_team_id'] != null &&
        teamsList.teams
            .map((e) => e.$id)
            .contains(element.data['participants_team_id']));

    // Должно вызываться последним
    await subscribeRealtime();

    emit(_Success(
      user,
      prefs,
      avatar,
      List<String>.from(eventsWithMembership.map((e) => e.data['name'])),
    ));
  }

  void started() async {
    try {
      emit(const _Loading());

      await account.get();

      await _loadUserData();
    } catch (e) {
      try {
        final sessions = await account.listSessions();

        for (final session in sessions.sessions) {
          if (session.provider == 'mirea') {
            await account.deleteSession(sessionId: session.$id);
          }
        }
      } catch (e) {}

      emit(const _LoginScreen());
    }
  }

  void register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const _Loading());

    try {
      await account.create(
          userId: ID.unique(), name: name, email: email, password: password);
      await account.createEmailSession(email: email, password: password);
      await _loadUserData();
    } on AppwriteException catch (e) {
      emit(_Error(_mapErrorsToMessage(e.message)));
    }
  }

  void logout() async {
    emit(const _Loading());

    try {
      await account.deleteSession(sessionId: 'current');
      subscription?.close();
      emit(const _LoginScreen());
    } on AppwriteException catch (e) {
      emit(_Error(_mapErrorsToMessage(e.message)));
    }
  }

  void login({
    String? email,
    String? password,
  }) async {
    emit(const _Loading());

    try {
      if (email != null && password != null) {
        await account.createEmailSession(
          email: email,
          password: password,
        );
        await _loadUserData();
      } else {
        try {
          await account.createOAuth2Session(
            provider: 'mirea',
          );
        } catch (e) {
          emit(const _LoginScreen());
        }
      }

      await _loadUserData();
    } on AppwriteException catch (e) {
      emit(_Error(_mapErrorsToMessage(e.message)));
    }
  }
}
