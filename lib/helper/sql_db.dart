import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDB {
  static Database? _database;

  static Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await intialDB();

    return _database;
  }

  static Future<Database> intialDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'todoapp.db');

    Database appDB = await openDatabase(path, onCreate: _onCreate, version: 1);

    return appDB;
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
           CREATE TABLE "task" (
           id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
           title TEXT NOT NULL,
           description TEXT NOT NULL,
           createdat TEXT NOT NULL,
           done INTEGER NOT NULL DEFAULT 0
           )
           ''');
  }

  static Future<List<Map<String, dynamic>>> selectData(String sql) async {
    Database? db = await database;
    List<Map<String, dynamic>> respone = await db!.rawQuery(sql);
    return respone;
  }

  static Future<int> insertData(String sql) async {
    Database? db = await database;
    int respone = await db!.rawInsert(sql);
    return respone;
  }

  static Future<int> updateData(String sql) async {
    Database? db = await database;
    int respone = await db!.rawUpdate(sql);
    return respone;
  }

  static Future<int> deleteData(String sql) async {
    Database? db = await database;
    int respone = await db!.rawDelete(sql);
    return respone;
  }
}
