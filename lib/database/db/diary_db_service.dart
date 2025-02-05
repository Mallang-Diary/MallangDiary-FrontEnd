import 'dart:async';

import 'package:mallang_project_v1/database/model/diary.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// 일기정 정보

class DiaryDBService {

  late Database _database;
  final table_name = 'diary';

  Future<Database> get database async {
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'mallang_diary.db');
    return await openDatabase(path, version: 2, onCreate: (db, version) async {
      await db.execute('''
            CREATE TABLE diary(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              date TEXT NOT NULL,
              time TEXT NOT NULL,
              title TEXT NOT NULL,
              context TEXT,
              isChecked INTEGER NOT NULL DEFAULT 0,
              FOREIGN KEY(userId) REFERENCES user(id) ON DELETE CASCADE
            )
          ''');
    }, onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        await db
            .execute('ALTER TABLE user_diary ADD COLUMN title TEXT NOT NULL');
        await db.execute(
            'ALTER TABLE user_diary ADD COLUMN isChecked INTEGER NOT NULL DEFAULT 0');
      }
    });
  }

  ///////////////////////////////////////////////////////////////////////////////////////
  //// DB API
  ///////////////////////////////////////////////////////////////////////////////////////

  // DB 전체 들고 오기
  Future<List<Diary>> getAllDiaryInfo() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(table_name);

    if (maps.isEmpty) return [];

    List<Diary> list = List.generate(
      maps.length,
          (index) {
        return Diary(
          id: maps[index]["id"],
          date: maps[index]["date"],
          time: maps[index]["time"],
          title: maps[index]["title"],
          context: maps[index]["context"],
          isChecked: maps[index]["isChecked"],
        );
      },
    );

    return list;
  }

  Future<List<Diary>> getQuery(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.rawQuery(query);

    if (maps.isEmpty) return [];

    List<Diary> list = List.generate(
      maps.length,
          (index) {
        return Diary(
          id: maps[index]["id"],
          date: maps[index]["date"],
          time: maps[index]["time"],
          title: maps[index]["title"],
          context: maps[index]["context"],
          isChecked: maps[index]["isChecked"],
        );
      },
    );

    return list;
  }

  Future<List<Diary>> getByUserId(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      table_name,
      where: 'userId = ?',
      whereArgs: [userId],
    );

    if ( maps.isEmpty) return [];

    return List.generate(
      maps.length,
          (i) {
        return Diary.fromJson(maps[i]);
      },
    );
  }


  Future<List<Diary>> getAllByMonth(DateTime month) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(table_name,
        where: "date LIKE ?", whereArgs: ["%${month.year}-${month.month}%"]);

    if (maps.isEmpty) return [];

    List<Diary> list = List.generate(
      maps.length,
          (index) {
        return Diary(
          id: maps[index]["id"],
          date: maps[index]["date"],
          time: maps[index]["time"],
          title: maps[index]["title"],
          context: maps[index]["context"],
          isChecked: maps[index]["isChecked"],
        );
      },
    );

    return list;
  }

  Future<void> insert(Diary userDiary) async {
    final db = await database;
    print(
        "UserDiary insert ${userDiary.id} (${userDiary.date}:${userDiary.time}");
    userDiary.id = await db.insert(table_name, userDiary.toJson());
  }

  Future<int> countAll() async {
    final db = await database;
    final count = Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $table_name'));
    return count ?? 0;
  }

  // 이번달 일기 개수
  Future<int> countThisMonth() async {
    final db = await database;
    final now = DateTime.now();
    final currentMonth = "${now.year}-${now.month.toString().padLeft(2, '0')}";
    final count = Sqflite.firstIntValue(await db!.rawQuery(
        'SELECT COUNT(*) FROM $table_name WHERE strftime("%Y-%m", date) = ?',
        [currentMonth]));
    return count ?? 0;
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
