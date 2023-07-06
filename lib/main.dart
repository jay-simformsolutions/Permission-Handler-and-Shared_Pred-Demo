import 'package:flutter/material.dart';
import 'package:permission_handler_demo/demo_page.dart';
import 'package:permission_handler_demo/extensions/provider_extension.dart';
import 'package:permission_handler_demo/routes/navigator_service.dart';
import 'package:permission_handler_demo/routes/route_generator.dart';
import 'package:permission_handler_demo/shared_preference/shared_pref.dart';
import 'package:permission_handler_demo/store/custom_file_picker_store.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPref.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorKey: NavigationService.instance.navigationKey,
      home: const DemoPage(),
    ).withProvider(CustomFilePickerStore());
  }
}
