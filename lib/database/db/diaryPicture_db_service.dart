import 'package:mallang_project_v1/database/db/diary_db_service.dart';
import 'package:mallang_project_v1/database/model/diary_picture.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DiaryPictureDBService {
  late Database _database;
  final table_name = 'diary_picture';

  Future<Database> get database async {
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'mallang_diary.db');
    return await openDatabase(path, version: 3, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE diary_picture(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userDiaryId INTEGER,
            picture BLOB NOT NULL,
            FOREIGN KEY(userDiaryId) REFERENCES user_diary(id) ON DELETE CASCADE
          )
        ''');
    }, onUpgrade: (db, oldVersion, newVersion) {});
  }

  ///////////////////////////////////////////////////////////////////////////////////////
  //// DB API
  ///////////////////////////////////////////////////////////////////////////////////////

  Future<List<DiaryPictures>> getAllDiaryPictures() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table_name);

    if (maps.isEmpty) return [];

    List<DiaryPictures> list = List.generate(
      maps.length,
          (i) {
        return DiaryPictures.fromJson(maps[i]);
      },
    );

    return list;
  }

  Future<void> insert(DiaryPictures userDiaryPicture) async {
    final db = await database;
    await db.insert(table_name, userDiaryPicture.toJson());
  }

  Future<void> deleteByUserId(int userId) async {
    final db = await database;

    final userDiaryService = DiaryDBService();
    final userDiaries = await userDiaryService.getByUserId(userId);

    final userDiaryIds = userDiaries.map((diary) => diary.id).toList();

    await db.delete(
      table_name,
      where: 'userDiaryId IN (${userDiaryIds.join(',')}',
    );
  }

}
