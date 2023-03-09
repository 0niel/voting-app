part of 'poll_bloc.dart';

@freezed
class PollEvent with _$PollEvent {
  const factory PollEvent.loadPolls(String eventId) = _LoadPolls;
  const factory PollEvent.processRealtimeEvent(RealtimeMessage message) =
      _ProcessRealtimeEvent;
}
