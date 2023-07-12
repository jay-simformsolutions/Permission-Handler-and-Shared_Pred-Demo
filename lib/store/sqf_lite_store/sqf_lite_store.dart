import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler_demo/database_helper/database_helper.dart';
import 'package:permission_handler_demo/routes/navigator_service.dart';

part 'sqf_lite_store.g.dart';

class SqfLiteStore = _SqfLiteStore with _$SqfLiteStore;

abstract class _SqfLiteStore with Store {
  _SqfLiteStore() {
    refreshUserData();
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();

  ObservableList<Map<String, dynamic>> userData = ObservableList.of([]);

  @observable
  bool isLoading = true;

  // This function is used to fetch all data from the database
  Future<void> refreshUserData() async {
    userData.clear();
    print('refresh data');
    // final data = await DataBaseHelper.instance.getItems();
    // userData.addAll(data);
    final result =
        await DataBaseHelper.instance.database.rawQuery('select  * from items');
    print(result);
    isLoading = false;
  }

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  Future<void> showForm(int? id) async {
    if (id != null) {
      final existingUserData =
          userData.firstWhere((element) => element['id'] == id);
      titleController.text = existingUserData['title'].toString();
      descriptionController.text = existingUserData['description'].toString();
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
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(hintText: 'Description'),
            ),
            const SizedBox(
              height: 20,
            ),
            // TextField(
            //   controller: departmentController,
            //   decoration: const InputDecoration(hintText: 'Department'),
            // ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                // Save new journal
                if (id == null) {
                  await addItem();
                }

                if (id != null) {
                  await updateItem(id);
                }

                // Clear the text fields
                titleController.text = '';
                descriptionController.text = '';

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

  // Insert a new journal to the database
  Future<void> addItem() async {
    await DataBaseHelper.instance.createItem(
      titleController.text,
      descriptionController.text,
    );
    await refreshUserData();
  }

  // Update an existing journal
  Future<void> updateItem(int id) async {
    await DataBaseHelper.instance.updateItem(
      id,
      titleController.text,
      descriptionController.text,
    );
    await refreshUserData();
  }

  // Delete an item
  Future<void> deleteItem(int id) async {
    await DataBaseHelper.instance.deleteItem(id);
    ScaffoldMessenger.of(NavigationService.instance.context).showSnackBar(
      const SnackBar(
        content: Text('Successfully deleted a journal!'),
      ),
    );
    await refreshUserData();
  }

  Future<void> fetchUserData(String description) async {
    final result = await DataBaseHelper.instance.database.query(
      'items',
      where: 'description = ?',
      whereArgs: [description],
      distinct: true,
    );
    // final result = await DataBaseHelper.instance.database.rawQuery(
    //   'select description, count(*) as "total user"  from items group by description',
    // );
    print(result);
  }
}
