import 'package:appwrite/appwrite.dart';
import 'package:dart_appwrite/dart_appwrite.dart' as dart_appwrite;
import 'package:appwrite/models.dart' as Models;
import 'package:face_to_face_voting/blocs/events/events_bloc.dart';
import 'package:face_to_face_voting/blocs/poll/poll_bloc.dart';
import 'package:face_to_face_voting/data/local_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/profile/profile_bloc.dart';
import 'constants.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerFactory<ProfileBloc>(() => ProfileBloc(
        client: getIt(),
        account: getIt(),
        avatars: getIt(),
        localStorage: getIt(),
        databases: getIt(),
        teams: getIt(),
        realtime: getIt(),
      ));
  getIt.registerFactory<EventsBloc>(() => EventsBloc(
        client: getIt(),
        account: getIt(),
        avatars: getIt(),
        databases: getIt(),
        teams: getIt(),
        realtime: getIt(),
      ));
  getIt.registerFactory<PollBloc>(() => PollBloc(
        client: getIt(),
        account: getIt(),
        databases: getIt(),
        teams: getIt(),
        realtime: getIt(),
        health: getIt(),
      ));

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

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());
}
