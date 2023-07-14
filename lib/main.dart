import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler_demo/database_helper/database_helper.dart';
import 'package:permission_handler_demo/database_helper/mongo_db_database_helper/mongo_db_database_helper.dart';
import 'package:permission_handler_demo/demo_page.dart';
import 'package:permission_handler_demo/routes/navigator_service.dart';
import 'package:permission_handler_demo/routes/route_generator.dart';
import 'package:permission_handler_demo/secure_storage/secure_storage.dart';
import 'package:permission_handler_demo/shared_preference/shared_pref.dart';
import 'package:permission_handler_demo/store/custome_file_picker_store/custom_file_picker_store.dart';
import 'package:permission_handler_demo/store/shared_pref_store/registration_store.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: 'AIzaSyDkatX1uRyEAJ7iQL7A6kqsmeilTpa-0ZQ',
            appId: '1:928113493849:android:4076daeb7cf47dcd8b2e48',
            messagingSenderId: '928113493849 ',
            projectId: 'fir-demo-1cfbe',
          ),
        )
      : await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: 'AIzaSyD5SguxVKOM2PCOFZruIaKwvdtCgJT4LxU',
            appId:
                '928113493849-4vfe1nvrnmigvd2uhm1fm58pts7epsd2.apps.googleusercontent.com',
            messagingSenderId: '928113493849',
            projectId: 'fir-demo-1cfbe',
            iosClientId:
                'com.googleusercontent.apps.928113493849-4vfe1nvrnmigvd2uhm1fm58pts7epsd2',
            iosBundleId: 'com.example.ios',
            storageBucket: 'fir-demo-1cfbe.appspot.com',
          ),
        );

  await DataBaseHelper.instance.init();
  await MongodbDatabaseHelper.instance.connectToMongo();
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
