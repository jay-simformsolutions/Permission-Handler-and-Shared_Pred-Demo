import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'firebase_phone_authentication_store.g.dart';

class MobileNumberAuthStore = _MobileNumberAuthStore
    with _$MobileNumberAuthStore;

abstract class _MobileNumberAuthStore with Store {
  final phoneNumber = TextEditingController();

  final auth = FirebaseAuth.instance;
}
