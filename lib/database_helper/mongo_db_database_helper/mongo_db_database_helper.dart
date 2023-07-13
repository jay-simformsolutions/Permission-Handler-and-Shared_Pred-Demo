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

  final MONGO_CONN_URL =
      'mongodb+srv://sage:716giCKIZg3FoVji@mongodbcluster.ml6rrnt.mongodb.net/User?retryWrites=true&w=majority';

  final USER_COLLECTION = 'users';

  final connectString =
      'mongodb+srv://sage:716giCKIZg3FoVji@mongodbcluster.ml6rrnt.mongodb.net/?retryWrites=true&w=majority';

  // ignore: inference_failure_on_function_return_type
  Future<void> connectToMongo() async {
    print('connect to mongo');
    try {
      print('connect to mongo 3 ${Db(connectString)}');

      database = await Db.create(connectString);
      await database?.open();
      debugPrint('Data base is Conneced');
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
  }

  Future<dynamic> insert(UserModel user) async {
    await userCollection?.insertAll([user.toMap()]);
  }

  Future<dynamic> update(UserModel user) async {
    var u = await userCollection?.findOne({'_id': user.id});
    u?['name'] = user.name;
    u?['age'] = user.age;
    u?['phone'] = user.phone;
    await userCollection?.replaceOne(userCollection, user.toMap());
  }

  Future<dynamic> delete(UserModel user) async {
    await userCollection?.remove(where.id(user.id));
  }
}
