import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthClass {
  static Future<User?> registerUser({
    required String? name,
    required String? email,
    required String? password,
  }) async {
    final firebaseAuth = FirebaseAuth.instance;
    User? user;

    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      user = userCredential.user;
      await user?.reload();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return user;
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    final auth = FirebaseAuth.instance;
    User? user;

    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided.');
      }
    }

    return user;
  }

  static Future<User?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleSignInAccount = await googleSignIn.signIn();

    final auth = FirebaseAuth.instance;
    User? user;

    // await FirebaseAuth.instance.signInWithProvider(GoogleAuthProvider());

    try {
      if (googleSignInAccount != null) {
        final googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final authResult = await auth.signInWithCredential(authCredential);
        final currentUser = auth.currentUser;
        debugPrint('Current user is $currentUser');

        user = authResult.user;
      } else {
        debugPrint('No google Account find in your phone');
      }
    } on PlatformException catch (e, s) {
      debugPrintStack(stackTrace: s);
      debugPrint('Exception is $e');
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      debugPrint('Exception is $e');
    }

    return user;
  }

  static Future<void> signInWithPhoneNumber(
      String phoneNumber, BuildContext context) async {
    final auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) {
        debugPrint('Verification is Success');
      },
      verificationFailed: (error) {
        debugPrint('Error is $error');
      },
      timeout: const Duration(seconds: 60),
      codeSent: (String verificationId, int? forceResendingToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
