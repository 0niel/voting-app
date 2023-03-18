part of 'user_cubit.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loginScreen() = _LoginScreen;
  const factory UserState.loading() = _Loading;
  const factory UserState.success(
    Models.Account user,
    Models.Preferences prefs,
    Image avatar,
    List<String> events,
  ) = _Success;
  const factory UserState.error(String message) = _Error;
}
