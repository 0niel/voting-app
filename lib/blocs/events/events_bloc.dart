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

  final RealtimeSubscription subscription;
  late final Models.Account me;

  EventsBloc({
    required this.client,
    required this.account,
    required this.avatars,
    required this.databases,
    required this.teams,
    required this.realtime,
    required this.subscription,
  }) : super(const _Initial()) {
    subscription.stream.listen((event) {
      final eventAction = event.events.first.split('.').last;

      if (eventAction != 'create' &&
          eventAction != 'update' &&
          eventAction != 'delete') {
        return;
      }

      print('Event action: $eventAction');

      final doc = Models.Document.fromMap(event.payload);

      if (doc.$collectionId == eventsCollectionId) {
        add(EventsEvent.loadEventsList(event: event));
      }
    });

    on<_LoadEventsList>(_loadEventsList);
    on<_LoadEvent>(loadEvent);
    on<_Started>(_loadEventsList);
  }

  Future<void> loadEvent(_LoadEvent e, Emitter<EventsState> emit) async {
    emit(const EventsState.loading());

    final documentResponse = await databases.getDocument(
      databaseId: databaseId,
      collectionId: eventsCollectionId,
      documentId: e.id,
    );

    emit(EventsState.eventLoaded(documentResponse));
  }

  Future<void> _loadEventsList(
    EventsEvent e,
    Emitter<EventsState> emit, {
    RealtimeMessage? event,
  }) async {
    emit(const EventsState.loading());

    me = await account.get();

    // получаем список событий из коллекции events сортирую по дате
    final documentsResponse = await databases.listDocuments(
      databaseId: databaseId,
      collectionId: eventsCollectionId,
      queries: [Query.orderDesc('start_at')],
    );

    print('Events: ${documentsResponse.documents}');

    // если есть события с атрибутом is_active = true, в которых мы являемся
    // участникам (находимся в team с id = participants_team_id в events)
    // то мы мы переключаем состояние на eventLoaded  иначе на eventsListLoaded
    if (documentsResponse.total > 0) {
      Models.Document? firstActiveEvent;

      for (final event in documentsResponse.documents) {
        if (event.data['is_active'] == true) {
          firstActiveEvent = event;
          break;
        }
      }

      if (firstActiveEvent != null) {
        final membershipResponse = await teams.listMemberships(
          teamId: firstActiveEvent.data['participants_team_id'],
        );

        // Если пользователь является участником активного на данный момент события
        if (membershipResponse.total > 0) {
          final List<String> members =
              membershipResponse.memberships.map((e) => e.userId).toList();

          if (members.contains(me.$id)) {
            emit(EventsState.eventLoaded(firstActiveEvent));
            return;
          }
        }
      }
    }

    emit(EventsState.eventsListLoaded(documentsResponse));
  }
}
