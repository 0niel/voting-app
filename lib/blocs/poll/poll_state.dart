part of 'poll_bloc.dart';

@freezed
class PollState with _$PollState {
  const factory PollState.initial() = _Initial;
  const factory PollState.loading() = _Loading;
  const factory PollState.success(
    String eventId,
    Models.Document poll,
    Models.DocumentList votes,
    Duration timeLeft,
  ) = _Success;
  const factory PollState.error(String message) = _Error;
  const factory PollState.noPoll() = _NoPoll;
}
