import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as Models;
import 'package:bloc/bloc.dart';
import 'package:face_to_face_voting/constants.dart';
import 'package:face_to_face_voting/data/sources/remote_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'participants_state.dart';
part 'participants_cubit.freezed.dart';

class ParticipantsCubit extends Cubit<ParticipantsState> {
  ParticipantsCubit({
    required this.account,
    required this.client,
    required this.databases,
    required this.teams,
    required this.remoteData,
  }) : super(const ParticipantsState.initial());

  final Account account;
  final Client client;
  final Databases databases;
  final Teams teams;
  final RemoteData remoteData;

  Future<Models.MembershipList> _loadParticipants(
      String eventId, String teamId) async {
    final documentsResponse = await databases.getDocument(
      databaseId: databaseId,
      collectionId: eventsCollectionId,
      documentId: eventId,
    );

    final participants = documentsResponse.data['participants_team_id'];

    final participantsResponse = await teams.listMemberships(
      teamId: participants,
    );

    return participantsResponse;
  }

  void load(String eventId) async {
    emit(const ParticipantsState.loading());

    try {
      final participantsResponse = await _loadParticipants(eventId, eventId);

      emit(ParticipantsState.loaded(participantsResponse));
    } catch (e) {
      emit(ParticipantsState.error(e.toString()));
    }
  }

  void addParticipant(String eventId, String userId) async {
    emit(const ParticipantsState.loading());

    try {
      final jwt = await account.createJWT();

      await remoteData.updateParticipantStatus(
        eventId,
        userId,
        jwt.jwt,
        UpdateType.add,
      );

      final participantsResponse = await _loadParticipants(eventId, eventId);

      emit(ParticipantsState.loaded(participantsResponse));
    } catch (e) {
      final prevState = state;
      emit(ParticipantsState.error(e.toString()));
      emit(prevState);
    }
  }

  void removeParticipant(String eventId, String userId) async {
    emit(const ParticipantsState.loading());

    try {
      final jwt = await account.createJWT();

      await remoteData.updateParticipantStatus(
        eventId,
        userId,
        jwt.jwt,
        UpdateType.delete,
      );

      final participantsResponse = await _loadParticipants(eventId, eventId);

      emit(ParticipantsState.loaded(participantsResponse));
    } catch (e) {
      final prevState = state;
      emit(ParticipantsState.error(e.toString()));
      emit(prevState);
    }
  }
}
