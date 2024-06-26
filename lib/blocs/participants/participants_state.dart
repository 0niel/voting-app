part of 'participants_cubit.dart';

@freezed
class ParticipantsState with _$ParticipantsState {
  const factory ParticipantsState.initial() = _Initial;
  const factory ParticipantsState.loading() = _Loading;
  const factory ParticipantsState.loaded(
    List<Models.Membership> participants,
  ) = _Loaded;
  const factory ParticipantsState.error(String message) = _Error;
}
