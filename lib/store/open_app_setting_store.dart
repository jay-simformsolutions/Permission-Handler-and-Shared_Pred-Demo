// ignore_for_file: inference_failure_on_instance_creation

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_demo/routes/navigator_service.dart';

part 'open_app_setting_store.g.dart';

class OpenAppSettingOnDialogStore = _OpenAppSettingOnDialogStore
    with _$OpenAppSettingOnDialogStore;

abstract class _OpenAppSettingOnDialogStore with Store {
  ///1. Make custom dialog for open setting
  Future<void> getPhotoPermission() async {
    final permissionStatus = await Permission.photos.status;

    debugPrint('Permission Status is $permissionStatus');
    if (permissionStatus.isGranted) {
      debugPrint('Permission is Granted');
    } else if (permissionStatus.isDenied) {
      //await Permission.photos.request();
      if (await Permission.photos.request().isGranted) {
        debugPrint('Permission is denied');
      }
    } else {
      /// iOS only open root settings not do further navigation
      await openCustomDialog();
    }
  }

  /// 2. Request another permission while one is running in background
  Future<void> multiplePermission() async {
    final permissionStatus = await Permission.photos.status;
    final contactPermission = await Permission.contacts.status;

    debugPrint('Permission Status is $permissionStatus');
    if (permissionStatus.isGranted) {
      debugPrint('Permission is Granted');
    } else if (permissionStatus.isDenied) {
      debugPrint('Request for Photos Permission');
      await Permission.photos.request();
      await Future.delayed(const Duration(seconds: 1));
      debugPrint('Request for Contacts Permission');
      await Permission.contacts.request();
      if (await Permission.photos.request().isGranted) {
        debugPrint('Permission is denied');
      }
    } else {
      /// iOS only open root settings not do further navigation
      await openCustomDialog();
    }
  }

  /// 3. Request multiple permission at a time
  Future<void> requestMultiplePermissionAtOnce() async {
    try {
      final result = [Permission.contacts, Permission.photos];

      for (final element in result) {
        if (await element.status.isGranted) {
          debugPrint('All Permission is granted');
        } else if (await element.status.isDenied) {
          await element.request();
        } else {
          await openAppSettings();
        }
      }
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      debugPrint('Exception is $e');
    }
  }

  Future<void> customPermissionDialog() async {
    final status = await Permission.camera.status;

    if (status.isGranted) {
      debugPrint('Permission is granted');
    } else if (status.isDenied) {
      await showDeniedDialog();
    } else {
      await openCustomDialog();
    }
  }

  /// Custom dialog dor open app setting
  Future<void> openCustomDialog() async {
    await showDialog<Widget>(
      context: NavigationService.instance.context,
      builder: (_) {
        return const AlertDialog(
          content: Text('You Denied Permission Please go to setting and grant'),
          actions: [TextButton(onPressed: openAppSettings, child: Text('Ok'))],
        );
      },
    );
  }

  Future<void> showDeniedDialog() async {
    await showDialog<Widget>(
      context: NavigationService.instance.context,
      builder: (context) => AlertDialog(
        content: const Text('Please Give Permission for Access Camera'),
        actions: [
          TextButton(
            onPressed: () {
              debugPrint('Permission of camera is allow');
              Permission.camera.isGranted;
              NavigationService.instance.goBack();
            },
            child: const Text('Allow'),
          ),
          TextButton(
            onPressed: () {
              debugPrint('Permission of camera is denied');
              Permission.camera.isDenied;
              NavigationService.instance.goBack();
            },
            child: const Text('Denied'),
          ),
        ],
      ),
    );
  }
}
