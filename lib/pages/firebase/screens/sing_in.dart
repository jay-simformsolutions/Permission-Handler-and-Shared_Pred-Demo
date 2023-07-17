import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler_demo/extensions/provider_extension.dart';
import 'package:permission_handler_demo/pages/firebase/screens/phone_authentication.dart';
import 'package:permission_handler_demo/pages/firebase/screens/profiles.dart';
import 'package:permission_handler_demo/pages/firebase/screens/sign_up.dart';
import 'package:permission_handler_demo/pages/firebase/utils/firebase_auth.dart';
import 'package:permission_handler_demo/pages/firebase/utils/validator.dart';
import 'package:permission_handler_demo/store/firebase_store/firebase_phone_authentication_store.dart';
import 'package:permission_handler_demo/store/firebase_store/firebase_sign_in_store.dart';
import 'package:permission_handler_demo/store/firebase_store/firebase_sign_up_store.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<FirebaseSignInStore>();
    return GestureDetector(
      onTap: () {
        store.focusEmail.unfocus();
        store.focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Authentication'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Form(
                key: store.signInFormKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: store.emailTextController,
                      focusNode: store.focusEmail,
                      validator: (value) => Validator.validateEmail(
                        email: value,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: store.passwordTextController,
                      focusNode: store.focusPassword,
                      obscureText: true,
                      validator: (value) => Validator.validatePassword(
                        password: value,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<Widget>(
                                builder: (context) =>
                                    const PhoneAuthentication().withProvider(
                                  MobileNumberAuthStore(),
                                ),
                              ),
                            );
                          },
                          child: const Text('Sign In With Mobile Number'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final user =
                                await FirebaseAuthClass.signInWithGoogle();

                            if (user != null) {
                              await Navigator.of(context).pushReplacement(
                                MaterialPageRoute<Widget>(
                                  builder: (context) => const ProfilesPage(),
                                ),
                              );
                            }
                          },
                          child: const Text('Sign In With Google'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Observer(
                      builder: (context) {
                        if (store.isProcessing) {
                          return const CircularProgressIndicator();
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    store.focusEmail.unfocus();
                                    store.focusPassword.unfocus();

                                    if (store.signInFormKey.currentState!
                                        .validate()) {
                                      store.isProcessing = true;

                                      final user = await FirebaseAuthClass
                                          .signInUsingEmailPassword(
                                        email: store.emailTextController.text,
                                        password:
                                            store.passwordTextController.text,
                                      );

                                      store.isProcessing = false;

                                      if (user != null) {
                                        // ignore: use_build_context_synchronously
                                        await Navigator.of(context)
                                            .pushReplacement(
                                          MaterialPageRoute<Widget>(
                                            builder: (context) =>
                                                const ProfilesPage(),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute<Widget>(
                                        builder: (context) =>
                                            const SignUpPage().withProvider(
                                          FirebaseSignUpStore(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
