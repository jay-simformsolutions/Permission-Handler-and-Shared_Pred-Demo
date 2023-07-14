import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:permission_handler_demo/pages/mongo_db_database/user_model/user_model.dart';

class MongodbDatabaseHelper {
  MongodbDatabaseHelper._internal();

  static final MongodbDatabaseHelper instance =
      MongodbDatabaseHelper._internal();

  static Db? database;
  static DbCollection? userCollection;

  final USER_COLLECTION = 'users';

  final connectString =
      'mongodb+srv://sage:716giCKIZg3FoVji@mongodbcluster.ml6rrnt.mongodb.net/?retryWrites=true&w=majority';

  // ignore: inference_failure_on_function_return_type
  Future<void> connectToMongo() async {
    print('connect to mongo');
    try {
      print('connect to mongo 3 ${debugDescribeFocusTree()}');

      database = await Db.create(connectString, debugDescribeFocusTree());

      await database?.open(secure: true, tlsAllowInvalidCertificates: true);
      debugPrint('Data base is Connected');
      inspect(database);
      userCollection = database?.collection(USER_COLLECTION);
    } catch (e) {
      debugPrint(e.toString());
    }
    print('connect to mango 2');
  }

  Future<List<Map<String, dynamic>>?>? getDocuments() async {
    try {
      final result = await userCollection?.find().toList();
      return result;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> insert(UserModel user) async {
    print('insert');

    await userCollection?.insert(user.toMap());
  }

  Future<void> update(UserModel user) async {
    final u = await userCollection?.findOne({'_id': user.id});

    debugPrint('After update name is ${user.name}');
    final result = await userCollection?.update(u, user.toMap());
    print(result);
  }

  Future<void> delete(UserModel user) async {
    await userCollection?.remove(where.id(user.id));
  }
}
