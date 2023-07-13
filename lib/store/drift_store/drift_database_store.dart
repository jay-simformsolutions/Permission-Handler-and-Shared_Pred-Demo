import 'package:drift/drift.dart' as driftDatabase;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler_demo/database_helper/drift_database_helper/drift_database_helper.dart';
import 'package:permission_handler_demo/routes/navigator_service.dart';

part 'drift_database_store.g.dart';

class DriftDatabaseStore = _DriftDatabaseStore with _$DriftDatabaseStore;

abstract class _DriftDatabaseStore with Store {
  _DriftDatabaseStore() {
    getAllTask();
  }

  final nameCnt = TextEditingController();
  final taskCnt = TextEditingController();

  // final isCompleteCnt = TextEditingController();
  final departmentCnt = TextEditingController();

  @observable
  bool isLoading = true;

  @observable
  bool isTaskCompleted = false;

  ObservableList<TaskData> tasks = ObservableList.of([]);

  final drift = DriftDatabaseHelper();

  // Future<void> refreshUserData() async {
  //   tasks.clear();
  //   print('refresh data');
  //   final data = await getAllTask();
  //   tasks.addAll(data);
  //   // print(result);
  //   isLoading = false;
  // }

  // Future<void> insertValue(String name, String task, bool isCompleted) async {
  //   final result = await drift.into(drift.task).insert(
  //         TaskCompanion.insert(
  //           name: name,
  //           task: task,
  //           isCompleted: isCompleted,
  //           createdAt: DateTime.now(),
  //         ),
  //       );
  //   print('Result is $result');
  // }

  Future<void> getAllTask() async {
    tasks.clear();
    final taskData = await drift.select(drift.task).get();
    tasks.addAll(taskData);
    debugPrint('TaskData is $taskData');
    isLoading = false;
  }

  Future<void> showForm(int? id) async {
    if (id != null) {
      final existingUserData = tasks.firstWhere((element) => element.id == id);
      nameCnt.text = existingUserData.name;
      taskCnt.text = existingUserData.task;
      isTaskCompleted = existingUserData.isCompleted;
    } else {
      nameCnt.clear();
      taskCnt.clear();
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
              controller: taskCnt,
              decoration: const InputDecoration(hintText: 'Task'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: departmentCnt,
              decoration: const InputDecoration(hintText: 'Department Name'),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Observer(
                  builder: (context) {
                    return Checkbox(
                      value: isTaskCompleted,
                      onChanged: (value) {
                        print('object $value');

                        isTaskCompleted = value!;
                      },
                    );
                  },
                ),
                const Text('Your Task is Completed?')
              ],
            ),
            // TextField(
            //   controller: isCompleteCnt,
            //   decoration: const InputDecoration(hintText: 'Task is Complete?'),
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
                nameCnt.text = '';
                taskCnt.text = '';
                departmentCnt.text = '';

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

  Future<void> addItem() async {
    await drift.into(drift.department).insert(
          DepartmentCompanion.insert(
            departmentId: departmentCnt.text == 'flutter'
                ? const driftDatabase.Value(1)
                : const driftDatabase.Value(0),
            departmentName: departmentCnt.text,
          ),
        );
    await drift.into(drift.task).insert(
          TaskCompanion.insert(
            name: nameCnt.text,
            task: taskCnt.text,
            isCompleted: isTaskCompleted,
            createdAt: DateTime.now(),
            departmentId: departmentCnt.text == 'flutter' ? 1 : 0,
          ),
        );
    await getAllTask();
  }

  Future<void> updateItem(int id) async {
    // drift.update(drift.task).where(
    //   (tbl) {
    //     return drift.task.id.equals(id);
    //   },
    // );

    final res = await drift.customSelect('select * from Task').get();
    print('Custom Selection is ${res.first.data}');

    final joinQuery = await drift
        .customSelect(
            'select Task.name As Emp_Name, Department.department_name AS departmentName FROM Task JOIN Department ON Task.department_id=Department.department_id')
        .get();
    print('Join Query is ${joinQuery.first.data}');

    await drift.customStatement(
      'UPDATE Task SET name=?,task=?,is_completed=? where id=$id',
      [
        nameCnt.text,
        taskCnt.text,
        isTaskCompleted,
      ],
    );

    await getAllTask();
  }

  Future<void> deleteItem(int id) async {
    await (drift.delete(drift.task)
          ..where(
            (tbl) {
              return drift.task.id.equals(id);
            },
          ))
        .go();

    await getAllTask();
  }
}
