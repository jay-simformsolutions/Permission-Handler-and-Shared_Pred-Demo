import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:permission_handler_demo/database_helper/mongo_db_database_helper/mongo_db_database_helper.dart';
import 'package:permission_handler_demo/pages/mongo_db_database/user_model/user_model.dart';
import 'package:permission_handler_demo/routes/navigator_service.dart';

part 'mongo_db_database_store.g.dart';

class MongodbDatabaseStore = _MongodbDatabaseStore with _$MongodbDatabaseStore;

abstract class _MongodbDatabaseStore with Store {
  _MongodbDatabaseStore() {
    getAllData();
  }
  ObservableList<UserModel> userList = ObservableList.of([]);

  final nameCnt = TextEditingController();
  final ageCnt = TextEditingController();
  final phoneCnt = TextEditingController();

  Future<void> getAllData() async {
    userList.clear();
    final result = await MongodbDatabaseHelper.instance.getDocuments();
    final data = result?.map(UserModel.fromJson).toList();
    userList.addAll(data ?? []);
  }

  Future<void> showForm(UserModel? userModel) async {
    if (userModel?.id != null) {
      final existingUserData =
          userList.firstWhere((element) => element.id == userModel?.id);
      nameCnt.text = existingUserData.name;
      phoneCnt.text = existingUserData.phone;
      ageCnt.text = existingUserData.age;
    } else {
      nameCnt.text = '';
      phoneCnt.text = '';
      ageCnt.text = '';
    }

    await showModalBottomSheet<Widget>(
      context: NavigationService.instance.context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          // this will prevent the soft keyboard from covering the text fields
          bottom: MediaQuery.of(NavigationService.instance.context)
                  .viewInsets
                  .bottom +
              120,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: nameCnt,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: ageCnt,
              decoration: const InputDecoration(hintText: 'Age'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: phoneCnt,
              decoration: const InputDecoration(hintText: 'Phone Number'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                // Save new journal
                if (userModel?.id == null) {
                  await addItem();
                }

                if (userModel?.id != null) {
                  await updateItem(userModel!.id);
                }

                // Clear the text fields
                nameCnt.text = '';
                ageCnt.text = '';
                phoneCnt.text = '';

                // Close the bottom sheet
                Navigator.of(NavigationService.instance.context).pop();
              },
              child: Text(userModel?.id == null ? 'Create New' : 'Update'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addItem() async {
    final user = UserModel(
      id: mongo.ObjectId(),
      name: nameCnt.text,
      phone: phoneCnt.text,
      age: ageCnt.text,
    );

    await MongodbDatabaseHelper.instance.insert(user);
    // await MongodbDatabaseHelper.instance.insert();

    await getAllData();
  }

  Future<void> updateItem(mongo.ObjectId userId) async {
    final user = UserModel(
      id: userId,
      name: nameCnt.text,
      phone: phoneCnt.text,
      age: ageCnt.text,
    );

    await MongodbDatabaseHelper.instance.update(user);

    await getAllData();
  }

  Future<void> deleteItem(UserModel userModel) async {
    // print('id is $id');
    await MongodbDatabaseHelper.instance.delete(userModel);

    await getAllData();
  }
}
