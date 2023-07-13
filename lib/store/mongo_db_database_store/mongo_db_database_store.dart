import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler_demo/pages/mongo_db_database/user_model/user_model.dart';

import '../../database_helper/mongo_db_database_helper/mongo_db_database_helper.dart';

part 'mongo_db_database_store.g.dart';

class MongodbDatabaseStore = _MongodbDatabaseStore with _$MongodbDatabaseStore;

abstract class _MongodbDatabaseStore with Store {
  ObservableList<UserModel> userList = ObservableList.of([]);

  final nameCnt = TextEditingController();
  final ageCnt = TextEditingController();
  final phoneCnt = TextEditingController();

  Future<void> getAllData() async {
    userList.clear();
    final result = await MongodbDatabaseHelper.instance.getDocuments();
    userList.addAll(result);
  }
}
