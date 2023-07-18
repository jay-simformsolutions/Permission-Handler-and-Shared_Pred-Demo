import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler_demo/pages/firebase/model/user_model.dart';
import 'package:permission_handler_demo/pages/firebase/utils/cloud_firestore_page.dart';
import 'package:permission_handler_demo/routes/navigator_service.dart';

part 'cloud_firestore_store.g.dart';

class FirebaseCloudStore = _FirebaseCloudStore with _$FirebaseCloudStore;

abstract class _FirebaseCloudStore with Store {
  final nameCnt = TextEditingController();
  final ageCnt = TextEditingController();
  final phoneNoCnt = TextEditingController();

  ObservableList<UserModel> userList = ObservableList.of([]);

  final fireStoreInstance = CloudFireStorePage.instance;

  _FirebaseCloudStore() {
    getAllUsers();
  }

  Future<void> getAllUsers() async {
    userList.clear();
    final response = await fireStoreInstance.getAllEntries('users');
    userList.addAll(response!);
    debugPrint('User list is $userList');
  }

  Future<void> addNewUser() async {
    final newUser = UserModel(
      name: nameCnt.text,
      age: int.parse(ageCnt.text),
      phoneNo: phoneNoCnt.text,
    );

    await fireStoreInstance.addNewUser('users', newUser.toJson());

    await getAllUsers();
  }

  Future<void> updateUser(String userId) async {
    final data = UserModel(
      name: nameCnt.text,
      age: int.parse(ageCnt.text),
      phoneNo: phoneNoCnt.text,
    );
    debugPrint('Data is Updated');
    await fireStoreInstance.updateEntryWithId(
      'users',
      userId,
      data.toJson(),
    );
  }

  Future<void> deleteUser(String docId) async {
    await fireStoreInstance.deleteUser('users', docId);

    await getAllUsers();
  }

  Future<void> showForm(String? id) async {
    if (id != null) {
      final existingUserData =
          userList.firstWhere((element) => element.userId == id);
      debugPrint('User id to be updated is ${existingUserData.userId}');
      nameCnt.text = existingUserData.name.toString();
      ageCnt.text = existingUserData.age.toString();
      phoneNoCnt.text = existingUserData.phoneNo;
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
              controller: phoneNoCnt,
              decoration: const InputDecoration(hintText: 'Phone No'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                // Save new journal
                if (id == null) {
                  await addNewUser();
                }

                if (id != null) {
                  await updateUser(id);
                }

                // Clear the text fields
                nameCnt.text = '';
                ageCnt.text = '';
                phoneNoCnt.text = '';

                // Close the bottom sheet
                Navigator.of(NavigationService.instance.context).pop();
              },
              child: Text(id == null ? 'Create New' : 'Update'),
            )
          ],
        ),
      ),
    );
  }
}
