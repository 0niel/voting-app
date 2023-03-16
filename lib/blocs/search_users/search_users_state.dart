part of 'search_users_cubit.dart';

@freezed
class SearchUsersState with _$SearchUsersState {
  const factory SearchUsersState.initial() = _Initial;
  const factory SearchUsersState.loading() = _Loading;
  const factory SearchUsersState.loaded(
    List<MapEntry<UserModel, bool>> users,
  ) = _Success;
  const factory SearchUsersState.loadedUser(
    MapEntry<UserModel, bool> user,
    Image avatar,
  ) = _SuccessUser;
  const factory SearchUsersState.error(
    String message,
  ) = _Error;
}
