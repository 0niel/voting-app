part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.started() = _Started;
  const factory ProfileEvent.login({
    String? email,
    String? password,
  }) = _Login;
  const factory ProfileEvent.logout() = _Logout;
}
