import 'dart:async';
import 'package:mallang_project_v1/database/model/diary_setting.dart';
import 'package:mallang_project_v1/database/model/user_diary.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDiaryService {

  static final UserDiaryService _userDiaryService = UserDiaryService._internal();
  UserDiaryService._internal(){
    // init values;

    /*
    async cannbot be used in constructur
     */
  }

  factory UserDiaryService() {
    return _userDiaryService;
  }


  late Database _database;
  final table_name = 'user_diary';

  Future<Database> get database async {
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'UserDiary.db');
    return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE user_diary(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              date TEXT NOT NULL,
              time TEXT NOT NULL,
              context TEXT,
              pictureList BLOB
            )
          ''');
        },
        onUpgrade: (db, oldVersion, newVersion){}
    );
  }

  // DB 전체 들고 오기
  Future<List<UserDiary>> getDB() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(table_name);
    if (maps.isEmpty) return [];

    List<UserDiary> list = List.generate(
      maps.length,
          (index) {
        return UserDiary(
          id: maps[index]["id"],
          date: maps[index]["date"],
          time: maps[index]["time"],
          context: maps[index]["context"],
          pictureList: maps[index]["pictureList"],
        );
      },
    );

    return list;
  }

  // 쿼리 날려서 들고오기
  Future<List<UserDiary>> getQuery(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.rawQuery(query);
    if (maps.isEmpty) return [];

    List<UserDiary> list = List.generate(
      maps.length,
          (index) {
        return UserDiary(
          id: maps[index]["id"],
          date: maps[index]["date"],
          time: maps[index]["time"],
          context: maps[index]["context"],
          pictureList: maps[index]["pictureList"],
        );
      },
    );

    return list;
  }

  // DB Insert ( 삽입 )
  Future<void> insert(UserDiary userDiary) async {
    final db = await database;
    print("UserDiary insert ${userDiary.id} (${userDiary.date}:${userDiary.time}");
    userDiary.id = await db?.insert(table_name, userDiary.toJson());
  }

  // (1). 사진만 지우는 것 ( 안에 내용만 변경하는 것 )
  // (2). 그 날짜에 해당하는 것을 싹 날려보내는 것

  Future<void> delete(UserDiary userDiary) async {
    final db = await database;
    print("UserDiary delete ${userDiary.id}");
    await db?.delete(
      table_name,
      where: "id = ?",
      whereArgs: [userDiary.id],
    );
  }

  // delete 가 2개
  Future<void> deleteDayDiary(int id) async {
    final db = await database;
    print("UserDiary delete all ${id}");
    await db?.delete(
      table_name,
      where: "id = ?",
      whereArgs: [id],
    );

  }

}

// 이미지 Uint8List 로 변환하기
// XFile? image = await picker.pickImage();
// picProvider.insert(Picture(specID: spec.id!, picture: await image.readAsBytes()));

// Uint8List 로 이미지 만들기
// Image.memory(Uint8List bytes);
//
// // in this database
// Picture pic;
// Image.memory(pic.picture)

// XFile 로 이미지 만들기
// Image.file(File(image.path))