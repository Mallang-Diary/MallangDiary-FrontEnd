import 'package:mallang_project_v1/database/model/user_diary_picture.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDiaryPictureService {
  late Database _database;
  final table_name = 'user_diary_picture';

  Future<Database> get database async {
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'UserDiaryPicture.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE user_diary_picture(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userDiaryId INTEGER,
            picture BLOB NOT NULL,
            FOREIGN KEY(userDiaryId) REFERENCES user_diary(id) ON DELETE CASCADE
          )
        ''');
    }, onUpgrade: (db, oldVersion, newVersion) {});
  }

  Future<void> insert(UserDiaryPicture userDiaryPicture) async {
    final db = await database;
    await db.insert(table_name, userDiaryPicture.toJson());
  }

  // getAll
  Future<List<UserDiaryPicture>> getAll() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table_name);
    if (maps.isEmpty) return [];

    List<UserDiaryPicture> list = List.generate(
      maps.length,
      (i) {
        return UserDiaryPicture.fromJson(maps[i]);
      },
    );

    return list;
  }

  Future<List<UserDiaryPicture>> getByUserDiaryIds(
      List<int> userDiaryIds) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      table_name,
      where: 'userDiaryId IN (${userDiaryIds.join(",")})',
    );
    if (maps.isEmpty) return [];

    List<UserDiaryPicture> list = List.generate(
      maps.length,
      (i) {
        return UserDiaryPicture.fromJson(maps[i]);
      },
    );

    return list;
  }
}
