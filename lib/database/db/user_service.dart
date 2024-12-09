import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserService {
  late Database _database;

  Future<Database> get database async {
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'User.db');
    return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE Specs(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nickname TEXT NOT NULL
            )
          ''');
        },
        onUpgrade: (db, oldVersion, newVersion){}
    );
  }
}