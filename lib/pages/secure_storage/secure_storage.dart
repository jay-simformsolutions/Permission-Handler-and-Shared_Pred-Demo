import 'package:flutter/material.dart';
import 'package:permission_handler_demo/routes/navigator_service.dart';
import 'package:permission_handler_demo/routes/routes.dart';
import 'package:permission_handler_demo/store/secure_storage_store/secure_storage_store.dart';
import 'package:provider/provider.dart';

class SecureStoragePage extends StatelessWidget {
  const SecureStoragePage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<SecureStorageStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secure Storage Demo'),
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
                controller: store.userNameCnt,
                decoration: const InputDecoration(
                  hintText: 'Enter User Name',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: store.passwordCnt,
                decoration: const InputDecoration(hintText: 'Enter Password'),
              ),
              TextButton(
                onPressed: () => NavigationService.instance
                    .navigateToScreen(Routes.sharedPrefRegistration),
                child: const Text("Don't have an account"),
              ),
              ElevatedButton(
                onPressed: () {
                  store
                    ..setUserCredential(
                      store.userNameCnt.text,
                      store.passwordCnt.text,
                    )
                    ..readUserCredential();
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
