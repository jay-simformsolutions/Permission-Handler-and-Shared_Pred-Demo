import 'package:flutter/material.dart';
import 'package:permission_handler_demo/routes/navigator_service.dart';
import 'package:permission_handler_demo/routes/routes.dart';
import 'package:permission_handler_demo/store/shared_pref_store/login_store.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<LoginStore>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_circle,
                size: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: store.userNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter User Name',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: store.emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter E-mail',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: store.passwordController,
                decoration: const InputDecoration(hintText: 'Enter Password'),
              ),
              TextButton(
                onPressed: () => NavigationService.instance
                    .navigateToScreen(Routes.sharedPrefRegistration),
                child: const Text("Don't have an account"),
              ),
              ElevatedButton(
                onPressed: () => store.userIsAlreadyExist(
                  store.emailController.text,
                ),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
