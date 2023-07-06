// ignore_for_file: cast_nullable_to_non_nullable

import 'package:flutter/material.dart';
import 'package:permission_handler_demo/demo_page.dart';
import 'package:permission_handler_demo/extensions/provider_extension.dart';
import 'package:permission_handler_demo/pages/custom_file_picker/custom_file_picker.dart';
import 'package:permission_handler_demo/pages/custom_file_picker/preview_page.dart';
import 'package:permission_handler_demo/pages/custom_file_picker/selected_images_page.dart';
import 'package:permission_handler_demo/pages/different_permission_page.dart';
import 'package:permission_handler_demo/pages/file_picker_demo.dart';
import 'package:permission_handler_demo/pages/open_app_setting_on_dialog.dart';
import 'package:permission_handler_demo/pages/secure_storage/secure_storage.dart';
import 'package:permission_handler_demo/pages/shared_pref_demo/login_page.dart';
import 'package:permission_handler_demo/pages/shared_pref_demo/registration.dart';
import 'package:permission_handler_demo/pages/shared_pref_demo/save_object.dart';
import 'package:permission_handler_demo/routes/routes.dart';
import 'package:permission_handler_demo/store/all_permission_store.dart';
import 'package:permission_handler_demo/store/file_picker_store.dart';
import 'package:permission_handler_demo/store/open_app_setting_store.dart';
import 'package:permission_handler_demo/store/secure_storage_store/secure_storage_store.dart';
import 'package:permission_handler_demo/store/shared_pref_store/login_store.dart';
import 'package:permission_handler_demo/store/shared_pref_store/save_object_store.dart';
import 'package:permission_handler_demo/store/shared_pref_store/shared_pref_content.dart';
import 'package:photo_manager/photo_manager.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const DemoPage(),
        );
      case Routes.openAppSettingOnCustomDialog:
        return MaterialPageRoute(
          builder: (_) => const OpenAppSettingOnDialog().withProvider(
            OpenAppSettingOnDialogStore(),
          ),
        );
      case Routes.allPermissions:
        return MaterialPageRoute(
          builder: (_) => const DifferentPermission().withProvider(
            AllPermissionStore(),
          ),
        );
      case Routes.filePicker:
        return MaterialPageRoute(
          builder: (_) => const FilePickerDemo().withProvider(
            FilePickerStore(),
          ),
        );
      case Routes.customFilePicker:
        return MaterialPageRoute(
          builder: (_) => const CustomFilePicker(),
        );
      case Routes.previewPage:
        return MaterialPageRoute(
          builder: (_) => PreviewPage(
            imagePreview: args as AssetEntity,
          ),
        );
      case Routes.selectImage:
        return MaterialPageRoute(
          builder: (_) => const SelectedImagesPage(),
        );
      case Routes.sharedPrefLogin:
        return MaterialPageRoute(
          builder: (_) => const LoginPage().withProvider(LoginStore()),
        );
      case Routes.sharedPrefRegistration:
        return MaterialPageRoute(
          builder: (_) => const RegistrationPage(),
        );
      case Routes.sharedPrefContent:
        return MaterialPageRoute(
          builder: (_) => const SharedPrefContent(),
        );
      case Routes.sharedPrefSaveObject:
        return MaterialPageRoute(
          builder: (_) =>
              const SharedPrefSaveObject().withProvider(SaveObjectStore()),
        );
      case Routes.secureStorage:
        return MaterialPageRoute(
          builder: (_) =>
              const SecureStoragePage().withProvider(SecureStorageStore()),
        );
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Error',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: const Center(
            child: Text('No Routes Found'),
          ),
        );
      },
    );
  }
}
