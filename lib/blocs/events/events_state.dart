part of 'events_cubit.dart';

@freezed
class EventsState with _$EventsState {
  const factory EventsState.initial() = _Initial;
  const factory EventsState.loading() = _Loading;
  const factory EventsState.eventsListLoaded(Models.DocumentList events) =
      _EventsListLoaded;
  const factory EventsState.eventLoaded(
    Models.Document event,
    bool isAcessModerator,
  ) = _EventLoaded;
  const factory EventsState.error(String message) = _Error;
}
