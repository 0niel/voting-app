part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _LoginInitial;
  const factory LoginState.loading() = _LoginLoading;
  const factory LoginState.success({required User user}) = _LoginSuccess;
}
