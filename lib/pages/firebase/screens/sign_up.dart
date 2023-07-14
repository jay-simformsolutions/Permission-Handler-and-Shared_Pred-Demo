import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler_demo/pages/firebase/utils/firebase_auth.dart';
import 'package:permission_handler_demo/pages/firebase/utils/validator.dart';
import 'package:permission_handler_demo/store/firebase_store/firebase_sign_up_store.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<FirebaseSignUpStore>();
    return GestureDetector(
      onTap: () {
        store.focusName.unfocus();
        store.focusEmail.unfocus();
        store.focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: store.registerFormKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: store.nameTextController,
                        focusNode: store.focusName,
                        validator: (value) => Validator.validateName(
                          name: value,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Name',
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 32),

                      // ignore: curly_braces_in_flow_control_structures
                      Observer(
                        builder: (context) {
                          if (store.isProcessing) {
                            return const CircularProgressIndicator();
                          } else {
                            return Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      store.isProcessing = true;

                                      if (store.registerFormKey.currentState!
                                          .validate()) {
                                        final user = await FirebaseAuthClass
                                            .registerUser(
                                          name: store.nameTextController.text,
                                          email: store.emailTextController.text,
                                          password:
                                              store.passwordTextController.text,
                                        );

                                        store.isProcessing = false;

                                        if (user != null) {
                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Register User Successfully'),
                                            ),
                                          );
                                          // Navigator.of(context)
                                          //     .pushAndRemoveUntil(
                                          //   MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         ProfilePage(user: user),
                                          //   ),
                                          //   ModalRoute.withName('/'),
                                          // );
                                        }
                                      }
                                    },
                                    child: const Text(
                                      'Sign up',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
