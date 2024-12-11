import 'dart:async';
import 'package:mallang_project_v1/database/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// 굳이 테이블까지 필요 없을 것 같음 --> 사용자는 1명이니까
// 나중에 diary_setting_service 에 함께 넣어도 될 것 같음

class UserService {
  late Database _database;
  final table_name = 'user';

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
            CREATE TABLE user(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nickname TEXT NOT NULL
            )
          ''');
        },
        onUpgrade: (db, oldVersion, newVersion){}
    );
  }

  // 혹시 몰라서 만든 함수 ( 모든 사용자 데이터 조회 )
  Future<List<User>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(table_name);

    if ( maps.isEmpty ) return [];

    List<User> list = maps.map((userMap) => User.fromJson(userMap)).toList();
    return list;
  }

  // 테이블 전체 삭제
  Future<void> clearUsers() async {
    final db = await database;
    await db?.delete(table_name);

  }

  // 쿼리 날려서 들고오기
  Future<List<User>> getQuery(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.rawQuery(query);
    if (maps.isEmpty) return [];

    List<User> list = List.generate(
      maps.length,
          (index) {
        return User(
          id: maps[index]["id"],
          nickname: maps[index]["nickname"],
        );
      },
    );

    return list;
  }

  Future<void> insert(User user) async {
    final db = await database;
    user.id = await db?.insert(table_name,user.toJson());
  }

  // DB Insert ( 삽입 )
  Future<void> update(User user) async {
    final db = await database;
    await db?.update(
      table_name,
      user.toJson(),
      where: "id = ?",
      whereArgs: [user.id],
    );

    // DB delete
    Future<void> delete(User user) async {
      final db = await database;
      await db?.delete(
        table_name,
        where: "id = ?",
        whereArgs: [user.id],
      );
    }
  }

  // 사용자 존재 여부 확인
  Future<bool> userExists() async {
    final db = await database;
    final result = await db.query(table_name, limit:1);

    return result.isNotEmpty;
  }
}