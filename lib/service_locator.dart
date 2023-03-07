import 'package:appwrite/appwrite.dart';
import 'package:dart_appwrite/dart_appwrite.dart' as dart_appwrite;
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
      localStorage: getIt()));
  getIt.registerFactory<EventsBloc>(() => EventsBloc(
        client: getIt(),
        account: getIt(),
        avatars: getIt(),
        databases: getIt(),
        teams: getIt(),
        realtime: getIt(),
        subscription: getIt(),
      ));
  getIt.registerFactory<PollBloc>(() => PollBloc(
        client: getIt(),
        account: getIt(),
        databases: getIt(),
        teams: getIt(),
        realtime: getIt(),
        health: getIt(),
        subscription: getIt(),
      ));

  getIt.registerLazySingleton<LocalStorage>(
      () => LocalStorage(storage: getIt()));

  final Client client = Client();

  getIt.registerLazySingleton<Client>((() => client
      .setEndpoint(appwriteEndpoint)
      .setProject(appwriteProjectId)
      .setSelfSigned(status: true)));

  getIt.registerLazySingleton<Account>(() => Account(getIt()));
  getIt.registerLazySingleton<Storage>(() => Storage(getIt()));
  getIt.registerLazySingleton<Databases>(() => Databases(getIt()));
  getIt.registerLazySingleton<Avatars>(() => Avatars(getIt()));
  getIt.registerLazySingleton<Teams>(() => Teams(getIt()));
  getIt.registerLazySingleton<Realtime>(() => Realtime(getIt()));
  RealtimeSubscription subscription = getIt<Realtime>().subscribe([
    'databases.$databaseId.collections.$eventsCollectionId',
    'databases.$databaseId.collections.$pollsCollectionId.documents',
    'databases.$databaseId.collections.$votesCollectionId.documents',
  ]);
  getIt.registerLazySingleton<RealtimeSubscription>(() => subscription);

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
