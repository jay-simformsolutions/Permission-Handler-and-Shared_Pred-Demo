import 'package:flutter/material.dart';
import 'package:permission_handler_demo/database_helper/mongo_db_database_helper/mongo_db_database_helper.dart';
import 'package:permission_handler_demo/demo_page.dart';
import 'package:permission_handler_demo/routes/navigator_service.dart';
import 'package:permission_handler_demo/routes/route_generator.dart';
import 'package:permission_handler_demo/secure_storage/secure_storage.dart';
import 'package:permission_handler_demo/shared_preference/shared_pref.dart';
import 'package:permission_handler_demo/store/custome_file_picker_store/custom_file_picker_store.dart';
import 'package:permission_handler_demo/store/shared_pref_store/registration_store.dart';
import 'package:provider/provider.dart';

import 'database_helper/database_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DataBaseHelper.instance.init();
  MongodbDatabaseHelper.instance.connectToMongo();
  SecureStorage.init();
  SharedPref.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => CustomFilePickerStore(),
        ),
        Provider(
          create: (context) => RegistrationStore(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: NavigationService.instance.navigationKey,
        home: const DemoPage(),
      ),
    );
  }
}
