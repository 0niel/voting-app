import 'package:appwrite/appwrite.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  Client client = Client();

  getIt.registerSingleton<Client>(client
      .setEndpoint('https://appwrite.mirea.ninja/v1')
      .setProject('63e13adf558da2437c76')
      .setSelfSigned());
}
