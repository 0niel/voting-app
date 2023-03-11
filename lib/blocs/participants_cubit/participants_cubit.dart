import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:bloc/bloc.dart';
import 'package:face_to_face_voting/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'participants_state.dart';
part 'participants_cubit.freezed.dart';

class ParticipantsCubit extends Cubit<ParticipantsState> {
  ParticipantsCubit({
    required this.client,
    required this.databases,
    required this.teams,
  }) : super(const ParticipantsState.initial());

  final Client client;
  final Databases databases;
  final Teams teams;

  void load(String eventId) async {
    emit(const ParticipantsState.loading());

    try {
      final documentsResponse = await databases.getDocument(
        databaseId: databaseId,
        collectionId: eventsCollectionId,
        documentId: eventId,
      );

      final participants = documentsResponse.data['participants_team_id'];

      final participantsResponse = await teams.listMemberships(
        teamId: participants,
      );

      emit(ParticipantsState.loaded(participantsResponse));
    } catch (e) {
      emit(ParticipantsState.error(e.toString()));
    }
  }
}
