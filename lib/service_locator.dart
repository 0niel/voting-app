import 'package:appwrite/appwrite.dart';
import 'package:dart_appwrite/dart_appwrite.dart' as dart_appwrite;
import 'package:dio/dio.dart';
import 'package:face_to_face_voting/blocs/events/events_cubit.dart';
import 'package:face_to_face_voting/blocs/participants/participants_cubit.dart';
import 'package:face_to_face_voting/blocs/poll/poll_cubit.dart';
import 'package:face_to_face_voting/blocs/resources/resources_cubit.dart';
import 'package:face_to_face_voting/blocs/search_users/search_users_cubit.dart';
import 'package:face_to_face_voting/data/sources/local_storage.dart';
import 'package:face_to_face_voting/data/sources/remote_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/user/user_cubit.dart';
import 'constants.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerLazySingleton<UserCubit>(() => UserCubit(
        client: getIt(),
        account: getIt(),
        avatars: getIt(),
        localStorage: getIt(),
        databases: getIt(),
        teams: getIt(),
        realtime: getIt(),
      ));
  getIt.registerLazySingleton<EventsCubit>(() => EventsCubit(
        client: getIt(),
        account: getIt(),
        avatars: getIt(),
        databases: getIt(),
        teams: getIt(),
        realtime: getIt(),
      ));
  getIt.registerLazySingleton<PollCubit>(() => PollCubit(
        client: getIt(),
        account: getIt(),
        databases: getIt(),
        teams: getIt(),
        realtime: getIt(),
        health: getIt(),
        remoteData: getIt(),
      ));
  getIt.registerLazySingleton<ParticipantsCubit>(() => ParticipantsCubit(
        account: getIt(),
        remoteData: getIt(),
        client: getIt(),
        databases: getIt(),
        teams: getIt(),
      ));
  getIt.registerLazySingleton<SearchUsersCubit>(() => SearchUsersCubit(
        avatars: getIt(),
        teams: getIt(),
        account: getIt(),
        remoteData: getIt(),
      ));
  getIt.registerLazySingleton<ResourcesCubit>(
      () => ResourcesCubit(databases: getIt()));

  getIt
      .registerLazySingleton<RemoteData>(() => RemoteData(httpClient: getIt()));
  getIt.registerLazySingleton<LocalStorage>(
      () => LocalStorage(storage: getIt()));

  final Client client = Client();

  getIt.registerLazySingleton<Client>((() =>
      client.setEndpoint(appwriteEndpoint).setProject(appwriteProjectId)));

  getIt.registerLazySingleton<Account>(() => Account(getIt<Client>()));
  getIt.registerLazySingleton<Storage>(() => Storage(getIt<Client>()));
  getIt.registerLazySingleton<Databases>(() => Databases(getIt<Client>()));
  getIt.registerLazySingleton<Avatars>(() => Avatars(getIt<Client>()));
  getIt.registerLazySingleton<Teams>(() => Teams(getIt<Client>()));
  getIt.registerLazySingleton<Realtime>(() => Realtime(getIt<Client>()));

  final dart_appwrite.Client dartClient = dart_appwrite.Client()
      .setEndpoint(appwriteEndpoint)
      .setProject(appwriteProjectId)
      .setKey(appwriteClientHealthApiKey);
  getIt.registerLazySingleton<dart_appwrite.Health>(
      () => dart_appwrite.Health(dartClient));

  final dio = Dio(BaseOptions(receiveTimeout: 20000));
  getIt.registerLazySingleton(() => dio);
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());
}
