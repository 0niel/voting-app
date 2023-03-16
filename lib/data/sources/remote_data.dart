import 'package:dio/dio.dart';
import 'package:face_to_face_voting/constants.dart';
import 'package:face_to_face_voting/data/models/user.dart';

enum UpdateType { add, delete }

class RemoteData {
  final Dio httpClient;

  RemoteData({required this.httpClient});

  void sendVote(String eventId, String pollId, String vote, String jwt) async {
    final response = await httpClient.post(
      '$apiUrl/votes/create',
      data: {
        'eventId': eventId,
        'pollId': pollId,
        'vote': vote,
        'jwt': jwt,
      },
      options: Options(
        headers: {
          'content-type': 'application/json',
        },
      ),
    );

    if (response.statusCode != 200) {
      try {
        final data = response.data as Map<String, dynamic>;
        final message = data['message'] as String;
        throw Exception(message);
      } catch (e) {
        throw Exception('При отправке голоса произошла ошибка');
      }
    }
  }

  Future<List<UserModel>> searchUsers(
      String eventID, String substring, String jwt) async {
    final response = await httpClient.post(
      '$apiUrl/users/search',
      data: {
        'eventID': eventID,
        'substring': substring,
        'jwt': jwt,
      },
    );

    if (response.statusCode != 200) {
      try {
        final data = response.data as Map<String, dynamic>;
        final message = data['message'] as String;
        throw Exception(message);
      } catch (e) {
        throw Exception('При поиске пользователей произошла ошибка');
      }
    }

    final data = response.data as Map<String, dynamic>;
    final users = (data['users'] as List<dynamic>)
        .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return users;
  }

  Future<void> updateParticipantStatus(
    String eventID,
    String receivedId,
    String jwt,
    UpdateType updateType,
  ) async {
    final data = {
      'eventID': eventID,
      'jwt': jwt,
      'receivedId': receivedId,
    };

    late final response;
    if (updateType == UpdateType.add) {
      response = await httpClient.post(
        '$apiUrl/events/update-participant',
        data: data,
      );
    } else {
      response = await httpClient.delete(
        '$apiUrl/events/update-participant',
        data: data,
      );
    }

    if (response.statusCode != 200) {
      try {
        final data = response.data as Map<String, dynamic>;
        final message = data['message'] as String;
        throw Exception(message);
      } catch (e) {
        throw Exception('При обновлении статуса участника произошла ошибка');
      }
    }
  }
}
