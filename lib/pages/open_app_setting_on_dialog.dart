// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:permission_handler_demo/routes/navigator_service.dart';
import 'package:permission_handler_demo/routes/routes.dart';
import 'package:permission_handler_demo/secure_storage/secure_storage.dart';
import 'package:permission_handler_demo/shared_preference/shared_pref.dart';
import 'package:permission_handler_demo/store/open_app_setting_store.dart';
import 'package:provider/provider.dart';

class OpenAppSettingOnDialog extends StatelessWidget {
  const OpenAppSettingOnDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<OpenAppSettingOnDialogStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Open App Setting'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: store.getPhotoPermission,
              child: const Text('Request Photos Permission'),
            ),
            ElevatedButton(
              onPressed: store.multiplePermission,
              child: const Text('Request Permission while another is running'),
            ),
            ElevatedButton(
              onPressed: store.requestMultiplePermissionAtOnce,
              child: const Text('Request Multiple Permission at a time'),
            ),
            ElevatedButton(
              onPressed: store.customPermissionDialog,
              child: const Text('Make Custom Permission Dialog'),
            ),
            ElevatedButton(
              onPressed: () => NavigationService.instance
                  .navigateToScreen(Routes.allPermissions),
              child: const Text('All Dangerous Permission'),
            ),
            ElevatedButton(
              onPressed: () => NavigationService.instance
                  .navigateToScreen(Routes.filePicker),
              child: const Text('File Picker'),
            ),
            ElevatedButton(
              onPressed: () => NavigationService.instance
                  .navigateToScreen(Routes.customFilePicker),
              child: const Text('Custom File Picker'),
            ),
            ElevatedButton(
              onPressed: () => NavigationService.instance
                  .navigateToScreen(Routes.sharedPrefLogin),
              child: const Text('Shared_Preference Demo'),
            ),
            ElevatedButton(
              onPressed: () => NavigationService.instance
                  .navigateToScreen(Routes.sharedPrefContent),
              child: const Text('Shared_Preference File Content'),
            ),
            ElevatedButton(
              onPressed: () => NavigationService.instance
                  .navigateToScreen(Routes.sharedPrefSaveObject),
              child: const Text('Save Object'),
            ),
            ElevatedButton(
              onPressed: () => NavigationService.instance
                  .navigateToScreen(Routes.secureStorage),
              child: const Text('Secure Storage Demo'),
            ),
            ElevatedButton(
              onPressed: () => NavigationService.instance
                  .navigateToScreen(Routes.sqfLitePage),
              child: const Text('Sqf_Lite Demo'),
            ),
            ElevatedButton(
              onPressed: () =>
                  NavigationService.instance.navigateToScreen(Routes.driftPage),
              child: const Text('Drift Demo'),
            ),
            ElevatedButton(
              onPressed: () => NavigationService.instance
                  .navigateToScreen(Routes.mongodbPage),
              child: const Text('Mongo Db Demo'),
            ),
            ElevatedButton(
              onPressed: () {
                SharedPref.instance?.clearSharedPref();
                SecureStorage.instance?.secureStorage.deleteAll();
              },
              child: const Text('Clear Shared_pref and Secure Storage'),
            ),
          ],
        ),
      ),
    );
  }
}
