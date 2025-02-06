import 'dart:async';

import 'package:mallang_project_v1/database/db/database_helper.dart';
import 'package:mallang_project_v1/database/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// 사용자 기본 정보

class UserDBService {

  final table_name = 'user';

  Future<Database> get database async => await DatabaseHelper.instance.database;

  ///////////////////////////////////////////////////////////////////////////////////////
  //// DB API
  ///////////////////////////////////////////////////////////////////////////////////////

  Future<bool> userExists() async {
    final db = await database;
    final result = await db.query(table_name, limit: 1);

    return result.isNotEmpty;
  }

  Future<User?> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db!.query(table_name, limit: 1);

    if (maps.isEmpty) return null;

    return User.fromJson(maps.first);
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(table_name);

    if (maps.isEmpty) return [];

    List<User> list = maps.map((userMap) => User.fromJson(userMap)).toList();
    return list;
  }

  Future<int> insert(User user) async {
    final db = await database;
    int id = await db.insert(table_name, user.toJson());

    user.id = id;
    return id;
  }

  Future<void> update(User user) async {
    final db = await database;
    await db?.update(
      table_name,
      user.toJson(),
      where: "id = ?",
      whereArgs: [user.id],
    );
  }

  Future<void> deleteById(int id) async {
    final db = await database;
    await db.delete(
      table_name,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteByUser(User user) async {
    final db = await database;
    await db?.delete(
      table_name,
      where: "id = ?",
      whereArgs: [user.id],
    );
  }

  Future<void> deleteAllUsers() async {
    final db = await database;
    await db?.delete(table_name);
  }

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

}
