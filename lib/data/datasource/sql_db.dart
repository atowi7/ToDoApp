import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLDB {
  static Database? _database;

  static Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initalDB();
    return _database;
  }

  static Future<Database> initalDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'todoapp.db');

    Database openDB = await openDatabase(path, onCreate: _onCreate, version: 1);

    return openDB;
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
       CREATE TABLE "category" (
          id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          icon INTEGER NOT NULL DEFAULT 0,
          color TEXT NOT NULL,
          createdat TEXT NOT NULL
        )
        ''');
    await db.execute('''
        CREATE TABLE "task" (
          id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          isdone INTEGER NOT NULL DEFAULT 0,
          createdat TEXT NOT NULL,
          categoryid INTEGER NOT NULL DEFAULT 0
        )
        ''');
  }

  static Future<List<Map<String, dynamic>>> selectData(String sql) async {
    Database? db = await database;

    List<Map<String, dynamic>> res = await db!.rawQuery(sql);

    return res;
  }

  static Future<int> insertData(String sql) async {
    Database? db = await database;

    int res = await db!.rawInsert(sql);

    return res;
  }

  static Future<int> updateData(String sql) async {
    Database? db = await database;

    int res = await db!.rawUpdate(sql);

    return res;
  }

  static Future<int> deleteData(String sql) async {
    Database? db = await database;

    int res = await db!.rawDelete(sql);

    return res;
  }
}
