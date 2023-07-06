import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler_demo/abstract_dispose/dispose.dart';
import 'package:permission_handler_demo/routes/navigator_service.dart';
import 'package:permission_handler_demo/routes/routes.dart';
import 'package:permission_handler_demo/shared_preference/shared_pref.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store implements Disposable {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future<void> userIsAlreadyExist(String email) async {
    final sharedPref = SharedPref.instance;
    // await sharedPref.getSharedPref();

    // debugPrint(
    //     'Email Store in Shared_Pref ${sharedPref.getEmail().toString()}');
    print(await sharedPref?.getEmail());
    if (sharedPref?.getEmail().toString() == email) {
      debugPrint('Inside If');
      ScaffoldMessenger.of(NavigationService.instance.context).showSnackBar(
        const SnackBar(
          content: Text('Login Success'),
        ),
      );
      NavigationService.instance.navigateToScreen(Routes.customFilePicker);
    } else {
      debugPrint('Inside Else');
      ScaffoldMessenger.of(NavigationService.instance.context).showSnackBar(
        const SnackBar(
          content: Text('No User Found Please Register First'),
        ),
      );
      NavigationService.instance
          .navigateToScreen(Routes.sharedPrefRegistration);
    }
  }

  @override
  void dispose() {}
}
