part of 'events_bloc.dart';

@freezed
class EventsEvent with _$EventsEvent {
  const factory EventsEvent.started() = _Started;
  const factory EventsEvent.loadEventsList({RealtimeMessage? event}) =
      _LoadEventsList;
  const factory EventsEvent.loadEvent(String id) = _LoadEvent;
  const factory EventsEvent.processRealtimeEvent(RealtimeMessage message) =
      _ProcessRealtimeEvent;
}
