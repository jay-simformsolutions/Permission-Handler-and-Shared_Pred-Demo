import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'drift_database_helper.g.dart';

class Task extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get task => text()();

  BoolColumn get isCompleted => boolean()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get departmentId =>
      integer().references(Department, #departmentId)();
}

class Department extends Table {
  IntColumn get departmentId => integer().nullable()();
  TextColumn get departmentName => text()();
}

abstract class DepartmentView extends View {
  Department get department;

  @override
  Query as() => select([department.departmentId, department.departmentName])
      .from(department);
}

abstract class TaskView extends View {
  Task get taskTable;

  @override
  // ignore: strict_raw_type
  Query as() => select([
        taskTable.task,
        taskTable.createdAt,
        taskTable.name,
        taskTable.isCompleted,
        taskTable.departmentId,
      ]).from(taskTable);
}

@DriftDatabase(tables: [Task, Department], views: [TaskView, DepartmentView])
// @DriftDatabase(tables: [Task], views: [TaskView])
class DriftDatabaseHelper extends _$DriftDatabaseHelper {
  DriftDatabaseHelper() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
