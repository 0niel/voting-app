import 'package:dio/dio.dart';
import 'package:face_to_face_voting/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
}
