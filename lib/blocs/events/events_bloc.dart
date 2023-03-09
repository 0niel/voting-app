import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as Models;
import 'package:bloc/bloc.dart';
import 'package:face_to_face_voting/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'events_event.dart';
part 'events_state.dart';
part 'events_bloc.freezed.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final Client client;
  final Account account;
  final Avatars avatars;
  final Databases databases;
  final Teams teams;
  final Realtime realtime;

  EventsBloc({
    required this.client,
    required this.account,
    required this.avatars,
    required this.databases,
    required this.teams,
    required this.realtime,
  }) : super(const _Initial()) {
    on<_LoadEventsList>(_loadEventsList);
    on<_LoadEvent>(_loadEvent);
    on<_Started>(_started);
    on<_ProcessRealtimeEvent>(_processRealtimeEvent);
  }

  Future<void> _processRealtimeEvent(
    _ProcessRealtimeEvent e,
    Emitter<EventsState> emit,
  ) async {
    final payload = e.message.payload;
    final doc = Models.Document.fromMap(payload);

    if (doc.$collectionId == eventsCollectionId) {
      add(EventsEvent.loadEventsList(event: e.message));
    }
  }

  Future<void> _loadEvent(_LoadEvent e, Emitter<EventsState> emit) async {
    emit(const EventsState.loading());

    final documentResponse = await databases.getDocument(
      databaseId: databaseId,
      collectionId: eventsCollectionId,
      documentId: e.id,
    );

    emit(EventsState.eventLoaded(documentResponse));
  }

  Future<void> _started(
    _Started e,
    Emitter<EventsState> emit,
  ) async {
    await _loadEventsList(e, emit);
  }

  Future<void> _loadEventsList(EventsEvent e, Emitter<EventsState> emit) async {
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
            emit(EventsState.eventLoaded(event));
            print('Event loaded: $event');
            return;
          } catch (e) {}
        }
      }
    }
    print('Events list loaded: ${documentsResponse.documents}');
    emit(EventsState.eventsListLoaded(documentsResponse));
  }
}
