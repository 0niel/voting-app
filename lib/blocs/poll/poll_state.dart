part of 'poll_cubit.dart';

@freezed
class PollState with _$PollState {
  const factory PollState.initial() = _Initial;
  const factory PollState.loading() = _Loading;
  const factory PollState.success(
    String eventId,
    Models.Document poll,
    List<Models.Document> votes,
    Duration timeLeft,
    double percentsLeft,
  ) = _Success;
  const factory PollState.error(String message) = _Error;
  const factory PollState.noPoll(String eventId) = _NoPoll;
}
