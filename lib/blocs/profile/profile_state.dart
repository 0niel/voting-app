part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loginScreen() = _LoginScreen;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.success(
    Models.Account user,
    Models.Preferences prefs,
    Image avatar,
    List<String> events,
  ) = _Success;
  const factory ProfileState.error(String message) = _Error;
}
