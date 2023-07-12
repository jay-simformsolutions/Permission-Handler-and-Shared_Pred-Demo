import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler_demo/secure_storage/secure_storage.dart';

part 'secure_storage_store.g.dart';

class SecureStorageStore = _SecureStorageStore with _$SecureStorageStore;

abstract class _SecureStorageStore with Store {
  _SecureStorageStore() {
    secureStorage?.readUserName().then(
          (value) => debugPrint('Value is $value'),
        );
  }

  TextEditingController userNameCnt = TextEditingController();
  TextEditingController passwordCnt = TextEditingController();

  final secureStorage = SecureStorage.instance;

  Future<void> setUserCredential(String userName, String userPassword) async {
    await secureStorage?.setUserName(userName);
    await secureStorage?.setPassword(userPassword);
  }

  void readUserCredential() {
    secureStorage?.readPassword().then(
          (value) => debugPrint('User name is $value'),
        );

    secureStorage?.readPassword().then(
          (value) => debugPrint('Password is $value'),
        );
  }
}
