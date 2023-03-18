part of 'resources_cubit.dart';

@freezed
class ResourcesState with _$ResourcesState {
  const factory ResourcesState.initial() = _Initial;
  const factory ResourcesState.loading() = _Loading;
  const factory ResourcesState.loaded(
    List<Models.Document> resources,
  ) = _Loaded;
  const factory ResourcesState.error(String message) = _Error;
}
