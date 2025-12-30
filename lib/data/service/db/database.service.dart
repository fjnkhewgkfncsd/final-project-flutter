import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'seedData.service.dart';

class DataBaseService {
  static final DataBaseService _instance = DataBaseService._internal();
  factory DataBaseService() => _instance;
  DataBaseService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await _onCreate(db, version);
        await SeedData().seedInitialData(db);
      },
      onOpen: _onOpen,
    );
  }

  Future<void> _onOpen(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE emergency(
        emergencyId INTEGER PRIMARY KEY AUTOINCREMENT,
        emergencyName TEXT,
        emergencyImage TEXT,
      )
    ''');

    await db.execute('''
      CREATE TABLE quiz(
        quizId INTEGER PRIMARY KEY AUTOINCREMENT,
        emergencyId INTEGER,
        FOREIGN KEY (emergencyId) REFERENCES emergency(emergencyId) ON DELETE CASCADE,
      ) 
    ''');

    await db.execute('''
      CREATE TABLE question(
        questionId INTEGER PRIMARY KEY AUTOINCREMENT,
        quizId INTEGER,
        questionTitle TEXT,
        FOREIGN KEY (quizId) REFERENCES quiz(quizId) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE emergencyAction(
        emergencyActionId INTEGER PRIMARY KEY AUTOINCREMENT,
        actionTitle TEXT,
        instruction TEXT,
        LevelOfDanger TEXT CHECK(LevelOfDanger IN ('Low', 'Medium', 'High'))
      )
    ''');

    await db.execute('''
      CREATE TABLE answer(
        answerId INTEGER PRIMARY KEY AUTOINCREMENT,
        questionId INTEGER,
        answerTitle TEXT,
        nextQuestionId INTEGER,
        emergencyActionId INTEGER,
        FOREIGN KEY (questionId) REFERENCES question(questionId) ON DELETE CASCADE,
        FOREIGN KEY (nextQuestionId) REFERENCES question(questionId) ON DELETE SET NULL,
        FOREIGN KEY (emergencyActionId) REFERENCES emergencyAction(emergencyActionId) ON DELETE SET NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE userAnswer(
        userAnswerId INTEGER PRIMARY KEY AUTOINCREMENT,
        answerId INTEGER,
        historyId INTEGER,
        quizId INTEGER,
        FOREIGN KEY (answerId) REFERENCES answer(answerId) ON DELETE CASCADE,
        FOREIGN KEY (historyId) REFERENCES history(historyId) ON DELETE CASCADE,
        FOREIGN KEY (quizId) REFERENCES quiz(quizId) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE history(
        historyId INTEGER PRIMARY KEY AUTOINCREMENT,
        quizId INTEGER,
        timestamp current_timestamp,
        FOREIGN KEY (quizId) REFERENCES quiz(quizId) ON DELETE CASCADE,
      )
    ''');

    await db.execute('''
      CREATE TABLE favorite_emergency(
        favoriteEmergencyId INTEGER PRIMARY KEY AUTOINCREMENT,
        emergencyId INTEGER,
        FOREIGN KEY (emergencyId) REFERENCES emergency(emergencyId) ON DELETE CASCADE,
      )
    ''');
  }
}