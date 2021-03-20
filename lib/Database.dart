import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:solid_erp/Hint.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
        join(await getDatabasesPath(), 'solid_database.db'),
        onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE IF NOT EXISTS hints (id INTEGER PRIMARY KEY, hint TEXT UNIQUE)");
    }, version: 1);
  }

  newHint(Hint newHint) async {
    final db = await database;
    await db.rawInsert("INSERT INTO hints (hint) VALUES (?)", [newHint.hint]);
  }

  Future<dynamic> getHint() async {
    final db = await database;
    var res = await db.query("hints");
    if (res.length == 0) {
      return [];
    } else {
      return res;
    }
  }
}
