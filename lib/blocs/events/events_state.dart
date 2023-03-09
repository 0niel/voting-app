part of 'events_bloc.dart';

@freezed
class EventsState with _$EventsState {
  const factory EventsState.initial() = _Initial;
  const factory EventsState.loading() = _Loading;
  const factory EventsState.eventsListLoaded(Models.DocumentList events) =
      _EventsListLoaded;
  // Factory который вызывает print
  const factory EventsState.eventLoaded(Models.Document event) = _EventLoaded;
}
