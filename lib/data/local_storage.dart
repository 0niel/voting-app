import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static const storage = FlutterSecureStorage();

  static Future<void> setTokenToCache(String token) async {
    await storage.write(key: 'auth_token', value: token);
  }

  static Future<String> getTokenFromCache() async {
    String token = await storage.read(key: 'auth_token') ?? '';
    return token;
  }

  static Future<void> removeTokenFromCache() async {
    await storage.deleteAll();
  }
}
