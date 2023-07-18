import 'package:flutter/material.dart';
import 'package:permission_handler_demo/extensions/provider_extension.dart';
import 'package:permission_handler_demo/pages/firebase/screens/profiles.dart';
import 'package:permission_handler_demo/pages/firebase/screens/sing_in.dart';
import 'package:permission_handler_demo/store/firebase_store/cloud_firestore_store.dart';
import 'package:permission_handler_demo/store/firebase_store/firebase_sign_in_store.dart';

class FirebasePage extends StatelessWidget {
  const FirebasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => const SignInPage().withProvider(
                        FirebaseSignInStore(),
                      ),
                    ),
                  );
                },
                child: const Text('Authentication'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => const ProfilesPage()
                          .withProvider(FirebaseCloudStore()),
                    ),
                  );
                },
                child: const Text('Get Existing User'),
              )
            ],
          ),
        ));
  }
}
