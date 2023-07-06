import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage.init() {
    instance ??= SecureStorage._internal();
    instance?.getSecureStorage();
  }
  SecureStorage._internal();

  static SecureStorage? instance = SecureStorage._internal();

  late final FlutterSecureStorage secureStorage;

  final userNameKey = 'userNameKey';
  final passwordKey = 'passwordKey';

  void getSecureStorage() {
    secureStorage = const FlutterSecureStorage();
  }

  Future<String?> readUserName() {
    return secureStorage.read(key: userNameKey);
  }

  Future<String?> readPassword() async {
    return secureStorage.read(key: passwordKey);
  }

  Future<void> setUserName(String name) async {
    await secureStorage.write(key: userNameKey, value: name);
  }

  Future<void> setPassword(String password) async {
    await secureStorage.write(key: passwordKey, value: password);
  }
}
