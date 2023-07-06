import 'package:flutter/material.dart';
import 'package:permission_handler_demo/store/all_permission_store.dart';
import 'package:provider/provider.dart';

class DifferentPermission extends StatelessWidget {
  const DifferentPermission({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<AllPermissionStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: store.cameraPermission,
              child: const Text('CAMERA'),
            ),
            ElevatedButton(
              onPressed: store.contactPermission,
              child: const Text('CONTACTS'),
            ),
            ElevatedButton(
              onPressed: store.calendarPermission,
              child: const Text('CALENDARS'),
            ),
            ElevatedButton(
              onPressed: store.photosPermission,
              child: const Text('PHOTOS'),
            ),
            ElevatedButton(
              onPressed: store.reminderPermission,
              child: const Text('REMINDERS'),
            ),
            ElevatedButton(
              onPressed: store.microPhonePermission,
              child: const Text('MICROPHONE'),
            ),
            ElevatedButton(
              onPressed: store.mediaLibraryPermission,
              child: const Text('MEDIAL LIBRARY'),
            ),
            ElevatedButton(
              onPressed: store.blueToothPermission,
              child: const Text('BLUETOOTH'),
            ),
            ElevatedButton(
              onPressed: store.sensorPermission,
              child: const Text('SENSORS'),
            ),
            ElevatedButton(
              onPressed: store.sensorPermission,
              child: const Text('APP TACKING TRANSPARENCY'),
            ),
            ElevatedButton(
              onPressed: store.speechRecognizerPermission,
              child: const Text('SPEECH RECOGNIZER'),
            ),
            ElevatedButton(
              onPressed: store.locationPermission,
              child: const Text('LOCATION'),
            ),
          ],
        ),
      ),
    );
  }
}
