import 'dart:async';
import 'package:mallang_project_v1/database/model/diary_setting.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// diary setting

class DiarySettingDBService {

  late Database _database;
  final table_name = 'diary_setting';

  Future<Database> get database async {
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'mallang_diary.db');
    return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE diary_setting(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              userId INTEGER,
              dayOfWeek TEXT,
              alarmTime TEXT,
              alarmSound TEXT,
              createdAt TEXT NOT NULL
            )
          ''');
        },
        onUpgrade: (db, oldVersion, newVersion){}
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////
  //// DB API
  ///////////////////////////////////////////////////////////////////////////////////////

  Future<List<DiarySetting>> getAllUsersDiarySetting() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(table_name);

    if (maps.isEmpty) return [];

    List<DiarySetting> list = List.generate(
      maps.length,
          (index) {
        return DiarySetting(
          id: maps[index]["id"],
          userId: maps[index]["userId"],
          dayOfWeek: maps[index]["dayOfWeek"],
          alarmTime: maps[index]["alarmTime"],
          alarmSound: maps[index]["alarmSound"],
          createdAt: maps[index]["createdAt"],
        );
      },
    );

    print("[GetAllDiarySetting] : {$maps[0][\"createdAt\"]");
    print("Info ==> : {$list}");

    return list;
  }

  Future<List<DiarySetting>> getQuery(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.rawQuery(query);

    if (maps.isEmpty) return [];

    List<DiarySetting> list = List.generate(
      maps.length,
          (index) {
        return DiarySetting(
          id: maps[index]["id"],
          userId: maps[index]["userId"],
          dayOfWeek: maps[index]["dayOfWeek"],
          alarmTime: maps[index]["alarmTime"],
          alarmSound: maps[index]["alarmSound"],
          createdAt: maps[index]["createdAt"],
        );
      },
    );

    return list;
  }

  Future<void> insert(DiarySetting diarySetting) async {
    final db = await database;
    diarySetting.id = await db?.insert(table_name,diarySetting.toJson());
  }

  Future<void> update(DiarySetting diarySetting) async {
    final db = await database;
    await db?.update(
      table_name,
      diarySetting.toJson(),
      where: "id = ?",
      whereArgs: [diarySetting.id],
    );
  }

  Future<void> deleteByUserId(int userId) async {
    final db = await database;
    await db.delete(
      table_name,
      where: "userId = ?",
      whereArgs: [userId],
    );
  }

}

