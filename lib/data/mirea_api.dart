import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:face_to_face_voting/models/user.dart';

class MireaApi {
  static const apiUrl = 'https://lk.mirea.ru/local/ajax/mrest.php';

  Future<String> logIn(String login, String password) async {
    final data = {"action": "login", "login": login, "password": password};
    final response = await Dio().get(apiUrl, queryParameters: data);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.data);
      if (jsonResponse.containsKey('errors')) {
        throw Exception(jsonResponse['errors'][0]);
      }
      return jsonResponse['token'];
    } else {
      throw Exception('Response status code is $response.statusCode');
    }
  }

  Future<User> getProfileData(String token) async {
    final response = await Dio().get(
      apiUrl + '?action=getData&url=https://lk.mirea.ru/profile/',
      options: Options(
        headers: {'Authorization': token},
      ),
    );
    var jsonResponse = json.decode(response.data);
    if (jsonResponse.containsKey('errors')) {
      throw Exception(jsonResponse['errors'][0]);
    }
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else {
      throw Exception('Response status code is $response.statusCode');
    }
  }
}
