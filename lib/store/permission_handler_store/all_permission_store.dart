import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';

part 'all_permission_store.g.dart';

class AllPermissionStore = _AllPermissionStore with _$AllPermissionStore;

abstract class _AllPermissionStore with Store {
  Future<void> cameraPermission() async {
    await takePermission(Permission.camera);
  }

  Future<void> contactPermission() async {
    await takePermission(Permission.contacts);
  }

  Future<void> calendarPermission() async {
    await takePermission(Permission.calendar);
  }

  Future<void> photosPermission() async {
    await takePermission(Permission.photos);
  }

  Future<void> reminderPermission() async {
    await takePermission(Permission.reminders);
  }

  Future<void> microPhonePermission() async {
    await takePermission(Permission.microphone);
  }

  Future<void> mediaLibraryPermission() async {
    await takePermission(Permission.mediaLibrary);
  }

  Future<void> blueToothPermission() async {
    await takePermission(Permission.bluetooth);
  }

  Future<void> sensorPermission() async {
    await takePermission(Permission.sensors);
  }

  Future<void> appTackingTransparencyPermission() async {
    await takePermission(Permission.appTrackingTransparency);
  }

  Future<void> speechRecognizerPermission() async {
    await takePermission(Permission.speech);
  }

  Future<void> locationPermission() async {
    await takePermission(Permission.location);
  }

  /// Common Function for Request Different Permissions
  Future<void> takePermission(Permission permission) async {
    final status = await permission.status;

    if (status.isGranted) {
      debugPrint('Permission is Granted');
    } else if (status.isDenied) {
      debugPrint('Permission is Denied');
      debugPrint('Request for Permission');
      await permission.request();
      if (await permission.request().isGranted) {
        debugPrint('Permission is Granted');
      }
    } else {
      /// iOS only open root settings not do further navigation
      await openAppSettings();
    }
  }
}
