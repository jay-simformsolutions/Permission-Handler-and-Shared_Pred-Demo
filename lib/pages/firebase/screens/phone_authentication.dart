// ignore_for_file: inference_failure_on_instance_creation

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler_demo/pages/firebase/screens/verify_otp.dart';
import 'package:permission_handler_demo/store/firebase_store/firebase_phone_authentication_store.dart';
import 'package:provider/provider.dart';

class PhoneAuthentication extends StatelessWidget {
  const PhoneAuthentication({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<MobileNumberAuthStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Authentication'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Phone Verification',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'We need to register your phone without getting started!',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const SizedBox(
                      width: 40,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text(
                      '|',
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: store.phoneNumber,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone',
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '+91${store.phoneNumber.text}',
                      verificationCompleted: (phoneAuthCredential) {
                        debugPrint('Authentication Completed');
                      },
                      verificationFailed: (error) {
                        debugPrint('error is $error');
                      },
                      codeSent: (verificationId, forceResendingToken) {
                        debugPrint('Code is Sent');
                        Navigator.of(context).push(
                          MaterialPageRoute<Widget>(
                            builder: (context) => VerifyOTP(
                              verificationId: verificationId,
                            ),
                          ),
                        );
                      },
                      codeAutoRetrievalTimeout: (verificationId) {},
                    );
                  },
                  child: const Text('Send the code'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
