import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  final FlutterSecureStorage storage;

  LocalStorage({required this.storage});

  Future<void> setTokenToCache(String token) async {
    await storage.write(key: 'jwt', value: token);
  }

  Future<String?> getTokenFromCache() async {
    return await storage.read(key: 'jwt');
  }

  Future<void> removeTokenFromCache() async {
    await storage.deleteAll();
  }
}
