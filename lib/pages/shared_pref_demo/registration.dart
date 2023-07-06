import 'package:flutter/material.dart';
import 'package:permission_handler_demo/store/shared_pref_store/registration_store.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<RegistrationStore>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Registration Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: store.registerUserNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter User Name',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: store.registerEmailController,
                decoration: const InputDecoration(hintText: 'Enter Your Email'),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: store.registerPasswordController,
                decoration: const InputDecoration(hintText: 'Enter Password'),
              ),
              ElevatedButton(
                onPressed: () => store.onSuccessRegistration(
                  store.registerUserNameController.text,
                  store.registerPasswordController.text,
                  store.registerEmailController.text,
                ),
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
