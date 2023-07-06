import 'package:flutter/material.dart';
import 'package:permission_handler_demo/shared_preference/shared_pref.dart';
import 'package:permission_handler_demo/store/shared_pref_store/save_object_store.dart';
import 'package:provider/provider.dart';

class SharedPrefSaveObject extends StatelessWidget {
  const SharedPrefSaveObject({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<SaveObjectStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save an Object'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: store.nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter Your Name',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: store.ageController,
                decoration: const InputDecoration(hintText: 'Enter Your Age'),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: store.locationController,
                decoration: const InputDecoration(hintText: 'Enter Location'),
              ),
              ElevatedButton(
                onPressed: () => SharedPref.instance?.setUserData(
                  store.nameController.text,
                  store.locationController.text,
                  store.ageController.text,
                ),
                child: const Text('Save Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
