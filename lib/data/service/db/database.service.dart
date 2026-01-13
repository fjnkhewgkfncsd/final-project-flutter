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
    String path = join(await getDatabasesPath(), 'FirstAidBuddyApp_databaset2.db');
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
      CREATE TABLE category(
        categoryId INTEGER PRIMARY KEY AUTOINCREMENT,
        categoryName TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE emergency(
        emergencyId INTEGER PRIMARY KEY AUTOINCREMENT,
        emergencyName TEXT,
        categoryId INTEGER,
        emergencyIcon TEXT,
        FOREIGN KEY (categoryId) REFERENCES category(categoryId) ON DELETE CASCADE
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
      CREATE TABLE quiz(
        quizId INTEGER PRIMARY KEY AUTOINCREMENT,
        emergencyId INTEGER,
        startQuestion INTEGER,
        FOREIGN KEY (emergencyId) REFERENCES emergency(emergencyId) ON DELETE CASCADE,
        FOREIGN KEY (startQuestion) REFERENCES question(questionId) ON DELETE CASCADE
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
        FOREIGN KEY (answerId) REFERENCES answer(answerId) ON DELETE CASCADE,
        FOREIGN KEY (historyId) REFERENCES history(historyId) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE history (
        historyId INTEGER PRIMARY KEY AUTOINCREMENT,
        emergencyId INTEGER,
        timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (emergencyId) REFERENCES emergency(emergencyId) ON DELETE CASCADE
      );
    ''');

    await db.execute('''
      CREATE TABLE favorite(
        favoriteId INTEGER PRIMARY KEY AUTOINCREMENT,
        historyId INTEGER,
        FOREIGN KEY (historyId) REFERENCES history(historyId) ON DELETE CASCADE
      )
    ''');

    await db.execute('CREATE INDEX idx_emergency_category ON emergency(categoryId)');
    await db.execute('CREATE INDEX idx_quiz_emergency ON quiz(emergencyId)');
    await db.execute('CREATE INDEX idx_question_quiz ON question(quizId)');
    await db.execute('CREATE INDEX idx_answer_question ON answer(questionId)');
    await db.execute('CREATE INDEX idx_answer_action ON answer(emergencyActionId)');
    await db.execute('CREATE INDEX idx_userAnswer_history ON userAnswer(historyId)');
    await db.execute('CREATE INDEX idx_userAnswer_answer ON userAnswer(answerId)');
    await db.execute('CREATE INDEX idx_favorite_history ON favorite(historyId)');
  }
}