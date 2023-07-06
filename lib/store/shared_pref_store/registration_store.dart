import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler_demo/pages/custom_file_picker/custom_file_picker.dart';
import 'package:permission_handler_demo/routes/navigator_service.dart';
import 'package:permission_handler_demo/shared_preference/shared_pref.dart';

part 'registration_store.g.dart';

class RegistrationStore = _RegistrationStore with _$RegistrationStore;

abstract class _RegistrationStore with Store {
  TextEditingController registerUserNameController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();

  // ObservableList<String> emails = ObservableList.of([]);

  List<String> emails = [];

  Future<void> onSuccessRegistration(
    String userName,
    String passWord,
    String email,
  ) async {
    final sharedPref = SharedPref.instance;
    await sharedPref?.setUserName(userName);
    await sharedPref?.setPassword(passWord);
    await sharedPref?.setEmail(email);

    final getAllEmails = await sharedPref?.getAllEmails() ?? [];
    debugPrint('Total emails are ${getAllEmails.length}');

    if (getAllEmails.contains(email)) {
      debugPrint('Email is Already Registered');
    } else {
      debugPrint('Added Email is $email');
      emails.add(email);
      // emails = [...emails];

      debugPrint('List of Emails is $emails');
      await sharedPref?.setListOfEmail(emails);
    }

    clearController();

    await NavigationService.instance.replaceScreen(const CustomFilePicker());
  }

  void clearController() {
    registerEmailController.clear();
    registerPasswordController.clear();
    registerUserNameController.clear();
  }
}
