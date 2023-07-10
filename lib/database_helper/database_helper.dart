import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  DataBaseHelper._internal();

  static final DataBaseHelper instance = DataBaseHelper._internal();

  late Database database;

  static const databaseName = 'my_database.db';
  static int databaseVersion = 1;

  static const initScript =
      []; // Initialization script split into seperate statements
  static Map<int, String> migrationScripts = {
    1: '''
CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )''',
    2: '''
      CREATE TABLE department(
      id INTEGER FOREIGN KEY AUTOINCREMENT NOT NULL,
      departmentName TEXT,
      FOREIGN KEY (id) REFERENCES items(id)
      )''',
    3: 'SELECT items.id, items.title, items.description, department.department'
        ' FROM items INNER JOIN department ON items.id == department.id,'

    // 2: 'ALTER TABLE items ADD department STRING',
    // 3: 'ALTER TABLE items ADD email_id STRING',
  };

  // this opens the database (and creates it if it doesn't exist)
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, databaseName);
    debugPrint('Version name is $databaseVersion');
    // debugPrint('Path is $path');
    instance.database = await openDatabase(
      path,
      version: migrationScripts.length,
      onCreate: createTables,
      onDowngrade: (db, oldVersion, newVersion) async {
        print('old version $oldVersion and new version $newVersion');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        debugPrint('Inside onUpgrade');
        for (var i = oldVersion + 1; i <= newVersion; i++) {
          debugPrint('new version is $i');
          await db.execute(migrationScripts[i]!);
        }
      },
      onOpen: (db) {
        debugPrint('Data base is open');
      },
      singleInstance: false,
    );
  }

  // static Future<Database> db() async {
  //   return openDatabase(
  //     'my_database.db',
  //     version: 1,
  //     onCreate: (Database database, int version) async {
  //       await createTables(database);
  //     },
  //   );
  // }

  Future<void> createTables(Database database, int id) async {
    debugPrint('Inside create tables function');
    debugPrint('Version name is $databaseVersion');
    for (var i = 1; i < migrationScripts.length; i++) {
      debugPrint('Executed $i');
      await database.execute(migrationScripts[i]!);
    }
    // await database.execute('''
    // CREATE TABLE items(
    //     id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    //     title TEXT,
    //     description TEXT,
    //     createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    //   )
    //   ''');
  }

  /// Create new item (journal)
  Future<int> createItem(
    String title,
    String? description,
  ) async {
    // debugPrint('Version name is $databaseVersion');
    final db = instance.database;

    final data = {
      'title': title,
      'description': description,
    };

    final id = await db.insert(
      'items',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  /// Read all items (journals)
  Future<List<Map<String, dynamic>>> getItems() async {
    //debugPrint('Version name is $databaseVersion');
    final db = instance.database;
    return db.query('items', orderBy: 'id');
  }

  /// Read a single item by id
  Future<List<Map<String, dynamic>>> getItem(int id) async {
    debugPrint('Version name is $databaseVersion');
    final db = instance.database;
    return db.query('items', where: 'id = ?', whereArgs: [id], limit: 1);
  }

  /// Update an item by id
  Future<int> updateItem(int id, String title, String? description) async {
    //debugPrint('Version name is $databaseVersion');
    final db = instance.database;

    final data = {
      'title': title,
      'description': description,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('items', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  /// Delete
  Future<void> deleteItem(int id) async {
    final db = instance.database;
    try {
      await db.delete('items', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint('Something went wrong when deleting an item: $err');
    }
  }
}
