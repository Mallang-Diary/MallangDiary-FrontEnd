import 'dart:async';
import 'package:mallang_project_v1/database/model/diary_setting.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// 참고 사이트 : https://cyj893.github.io/flutter/Flutter2/

class DiarySettingService {
  late Database _database;
  final table_name = 'user_setting';

  Future<Database> get database async {
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'DiarySetting.db');
    return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE Specs(
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

  // DB 전체 들고오기
  Future<List<DiarySetting>> getDB() async {
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

    return list;
  }

  // 쿼리 날려서 들고오기
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

  // DB Insert ( 삽입 )
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

    // DB delete
    Future<void> delete(DiarySetting diarySetting) async {
      final db = await database;
      await db?.delete(
        table_name,
        where: "id = ?",
        whereArgs: [diarySetting.id],
      );
    }
  }
}