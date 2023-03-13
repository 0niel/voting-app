import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as Models;
import 'package:bloc/bloc.dart';
import 'package:face_to_face_voting/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'events_state.dart';
part 'events_cubit.freezed.dart';

class EventsCubit extends Cubit<EventsState> {
  final Client client;
  final Account account;
  final Avatars avatars;
  final Databases databases;
  final Teams teams;
  final Realtime realtime;

  EventsCubit({
    required this.client,
    required this.account,
    required this.avatars,
    required this.databases,
    required this.teams,
    required this.realtime,
  }) : super(const _Initial());

  Future<void> processRealtimeEvent(
    RealtimeMessage message,
  ) async {
    final payload = message.payload;
    final doc = Models.Document.fromMap(payload);

    if (doc.$collectionId == eventsCollectionId) {
      loadEventsList();
    }
  }

  void loadEvent(String id) async {
    emit(const EventsState.loading());

    final documentResponse = await databases.getDocument(
      databaseId: databaseId,
      collectionId: eventsCollectionId,
      documentId: id,
    );

    emit(EventsState.eventLoaded(
      documentResponse,
      await _isEventAcessModerator(documentResponse),
    ));
  }

  void started() async {
    await loadEventsList();
  }

  Future<bool> _isEventAcessModerator(Models.Document event) async {
    try {
      await teams.get(teamId: event.data['access_moderators_team_id']);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> loadEventsList() async {
    emit(const EventsState.loading());

    // получаем список событий из коллекции events сортирую по дате
    final documentsResponse = await databases.listDocuments(
      databaseId: databaseId,
      collectionId: eventsCollectionId,
      queries: [Query.orderDesc('start_at')],
    );

    // если есть события с атрибутом is_active = true, в которых мы являемся
    // участникам (находимся в team с id = participants_team_id в events)
    // то мы мы переключаем состояние на eventLoaded  иначе на eventsListLoaded
    if (documentsResponse.total > 0) {
      for (final event in documentsResponse.documents) {
        if (event.data['is_active'] == true) {
          try {
            await teams.get(teamId: event.data['participants_team_id']);
            emit(EventsState.eventLoaded(
              event,
              await _isEventAcessModerator(event),
            ));
            return;
          } catch (e) {
            continue;
          }
        }
      }
    }

    print('Events list loaded: ${documentsResponse.documents}');
    emit(EventsState.eventsListLoaded(documentsResponse));
  }
}
