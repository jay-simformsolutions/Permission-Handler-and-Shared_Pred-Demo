import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'firebase_sign_in_store.g.dart';

class FirebaseSignInStore = _FirebaseSignInStore with _$FirebaseSignInStore;

abstract class _FirebaseSignInStore with Store {
  final signInFormKey = GlobalKey<FormState>();

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final focusEmail = FocusNode();
  final focusPassword = FocusNode();

  @observable
  bool isProcessing = false;
}
