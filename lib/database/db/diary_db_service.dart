import 'dart:async';

import 'package:mallang_project_v1/database/db/database_helper.dart';
import 'package:mallang_project_v1/database/model/diary.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// 일기정 정보

class DiaryDBService {

  final table_name = 'diary';

  Future<Database> get database async => await DatabaseHelper.instance.database;

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
