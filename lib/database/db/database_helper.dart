import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'mallang_diary.db');
    return await openDatabase(
      path,
      version: 4,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    print("== [DB Create] ==");

    await db.execute('''
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nickname TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE diary(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        date TEXT NOT NULL,
        time TEXT NOT NULL,
        title TEXT NOT NULL,
        context TEXT,
        isChecked INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY(userId) REFERENCES user(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE diary_picture(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userDiaryId INTEGER NOT NULL,
        picture BLOB NOT NULL,
        FOREIGN KEY(userDiaryId) REFERENCES diary(id) ON DELETE CASCADE
      )
    ''');

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
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE diary ADD COLUMN title TEXT NOT NULL');
      await db.execute('ALTER TABLE diary ADD COLUMN isChecked INTEGER NOT NULL DEFAULT 0');
    }
  }
}
