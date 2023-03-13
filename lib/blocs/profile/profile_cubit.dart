import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:face_to_face_voting/constants.dart';
import 'package:face_to_face_voting/data/local_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:appwrite/models.dart' as Models;

import '../../service_locator.dart';
import '../events/events_cubit.dart';
import '../poll/poll_cubit.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final Client client;
  final Databases databases;
  final Account account;
  final Avatars avatars;
  final Teams teams;
  final LocalStorage localStorage;
  final Realtime realtime;

  RealtimeSubscription? subscription;

  void subscribeRealtime() async {
    if (subscription != null) {
      return;
    }

    subscription = realtime.subscribe([
      'databases.$databaseId.collections.$eventsCollectionId.documents',
      'databases.$databaseId.collections.$pollsCollectionId.documents',
      'databases.$databaseId.collections.$votesCollectionId.documents',
      'memberships'
    ]);

    print('Subscribed to realtime events');

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

        final doc = Models.Document.fromMap(event.payload);

        if (doc.$collectionId == eventsCollectionId) {
          getIt<EventsCubit>().processRealtimeEvent(event);
        } else if (doc.$collectionId == pollsCollectionId ||
            doc.$collectionId == votesCollectionId) {
          getIt<PollCubit>().processRealtimeEvent(event);
        } else {
          if (eventTarget == 'memberships') {
            // Возможно, что пользователя удалили или добавили в список участников
            // Поэтому нужно обновить список событий
            getIt<EventsCubit>().loadEventsList();
          }
        }
      },
      onError: (err, st) =>
          debugPrint('realtime_mixin:onError: ${err.toString()}'),
      onDone: () => debugPrint('realtime_mixin:onDone'),
      cancelOnError: false,
    );
  }

  String _cyryllicToLat(String text) {
    final Map<String, String> cyrillicToLatin = {
      "а": "a",
      "б": "b",
      "в": "v",
      "г": "g",
      "д": "d",
      "е": "e",
      "ё": "yo",
      "ж": "zh",
      "з": "z",
      "и": "i",
      "й": "j",
      "к": "k",
      "л": "l",
      "м": "m",
      "н": "n",
      "о": "o",
      "п": "p",
      "р": "r",
      "с": "s",
      "т": "t",
      "у": "u",
      "ф": "f",
      "х": "h",
      "ц": "c",
      "ч": "ch",
      "ш": "sh",
      "щ": "sh'",
      "ъ": "",
      "ы": "y",
      "ь": "",
      "э": "e",
      "ю": "yu",
      "я": "ya",
      " ": " ",
    };

    final List<String> letters = text.toLowerCase().split('');
    final List<String> latinLetters = [];

    for (var letter in letters) {
      if (cyrillicToLatin.containsKey(letter)) {
        latinLetters.add(cyrillicToLatin[letter]!);
      }
    }

    return latinLetters.join();
  }

  ProfileCubit({
    required this.client,
    required this.account,
    required this.avatars,
    required this.localStorage,
    required this.databases,
    required this.teams,
    required this.realtime,
  }) : super(const _Initial());

  Future<void> _loadUserData() async {
    final sessions = await account.listSessions();
    for (final session in sessions.sessions) {
      if (session.provider == 'mirea') {
        final headers = {
          'Authorization': 'Bearer ${session.providerAccessToken}',
        };

        final response = await Dio().get(
            'https://auth-app.mirea.ru/api/?action=getData&url=https://lk.mirea.ru/profile/',
            options: Options(headers: headers));

        final data = jsonDecode(response.data);

        final students = data["STUDENTS"].values.where((element) =>
            !element["PROPERTIES"]["PERSONAL_NUMBER"]["VALUE"].contains("Д") &&
            !element["PROPERTIES"]["PERSONAL_NUMBER"]["VALUE"].contains("Ж"));

        final studentsList = students.toList();

        final student = students.firstWhere(
            (element) => element['status'] == 'активный',
            orElse: () => students.first);

        await account.updatePrefs(prefs: {
          'id': data["ID"],
          'course': int.parse(student["PROPERTIES"]["COURSE"]["VALUE"]),
          'personalNumber': student["PROPERTIES"]["PERSONAL_NUMBER"]["VALUE"],
          'academicGroup': student["PROPERTIES"]["ACADEMIC_GROUP"]
              ["VALUE_TEXT"],
        });

        final user = await account.get();
        final jwt = await account.createJWT();
        final prefs = await account.getPrefs();

        final avatarByteList = await avatars.getInitials(
          name: _cyryllicToLat(user.name),
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
        subscribeRealtime();

        emit(_Success(
          user,
          prefs,
          jwt,
          avatar,
          List<String>.from(eventsWithMembership.map((e) => e.data['name'])),
        ));
      }
    }
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

  void login() async {
    emit(const _Loading());

    await account
        .createOAuth2Session(
          provider: 'mirea',
        )
        .then((value) => _loadUserData());
  }
}
