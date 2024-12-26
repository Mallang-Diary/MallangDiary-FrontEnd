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
            picturePath TEXT NOT NULL,
            FOREIGN KEY(userDiaryId) REFERENCES user_diary(id) ON DELETE CASCADE
          )
        ''');
    }, onUpgrade: (db, oldVersion, newVersion) {});
  }
}
