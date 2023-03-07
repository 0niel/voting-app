import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:face_to_face_voting/data/local_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:appwrite/models.dart' as Models;

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final Client client;
  final Account account;
  final Avatars avatars;
  final LocalStorage localStorage;

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

  Future<void> _loadUserData(Emitter<ProfileState> emit) async {
    final sessions = await account.listSessions();
    for (final session in sessions.sessions) {
      if (session.provider == 'mirea') {
        final headers = {
          'Authorization': 'Bearer ${session.providerAccessToken}',
        };

        final response = await Dio().get(
            'https://lks.mirea.ninja/api/?action=getData&url=https://lk.mirea.ru/profile/',
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
          'email': data["arUser"]["EMAIL"],
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

        emit(_Success(
          user,
          prefs,
          jwt,
          avatar,
        ));
      }
    }
  }

  ProfileBloc({
    required this.client,
    required this.account,
    required this.avatars,
    required this.localStorage,
  }) : super(const _Initial()) {
    on<_Started>(((event, emit) async {
      try {
        emit(const _Loading());
        final jwt = await localStorage.getTokenFromCache();
        if (jwt != null) {
          client.setJWT(jwt);
          await _loadUserData(emit);
        } else {
          emit(const _LoginScreen());
        }
      } catch (e) {
        // Очищаем токен при ошибке
        if (e.toString().contains('user_jwt_invalid')) {
          await localStorage.removeTokenFromCache();
        }
        emit(const _LoginScreen());
      }
    }));

    on<_Login>((event, emit) async {
      try {
        emit(const _Loading());

        final jwt = await localStorage.getTokenFromCache();
        if (jwt != null) {
          client.setJWT(jwt);
        } else {
          await account.createOAuth2Session(
            provider: 'mirea',
          );
          final jwt = (await account.createJWT());
          await localStorage.setTokenToCache(jwt.jwt);
        }

        await _loadUserData(emit);
      } catch (e) {
        emit(_Error(e.toString()));
      }
    });
  }
}
