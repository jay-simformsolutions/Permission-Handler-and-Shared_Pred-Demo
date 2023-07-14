import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'firebase_sign_up_store.g.dart';

class FirebaseSignUpStore = _FirebaseSignUpStore with _$FirebaseSignUpStore;

abstract class _FirebaseSignUpStore with Store {
  final registerFormKey = GlobalKey<FormState>();

  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final focusName = FocusNode();
  final focusEmail = FocusNode();
  final focusPassword = FocusNode();

  @observable
  bool isProcessing = false;
}
