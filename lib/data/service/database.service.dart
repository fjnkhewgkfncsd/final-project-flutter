import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
      onCreate: _onCreate,
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
        actionDescription TEXT,
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

  Future<void> insertExample(String name) async {
    final db = await database;
    await db.insert(
      'example_table',
      {'name': name},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getExamples() async {
    final db = await database;
    return await db.query('example_table');
  }

  Future<void> seedInitialData() async {
    final db = await database;
    final emergencyId = await db.insert('emergency', {
      'emergencyName': 'Fire',
      'emergencyImage': 'fire_image.png',
    });
    final quizId = await db.insert('quiz',{
      'emergencyId': emergencyId,
    });
    List<int> questionIds = [];
    List<Map<String, dynamic>> questions = [
        {
          'quizId': quizId,
          'questionTitle': 'You are inside a building that is on fire. What floor are you currently on?'
        },
        {
          'quizId': quizId,
          'questionTitle': 'Is there heavy smoke in your current location?'
        },
        {
          'quizId': quizId,
          'questionTitle': 'Is the exit door near you blocked by fire or smoke?'
        },
        {
          'quizId': quizId,
          'questionTitle': 'Does the door feel hot when you touch it?'
        },
        {
          'quizId': quizId,
          'questionTitle': 'Is there a staircase available nearby?'
        },
        {
          'quizId': quizId,
          'questionTitle': 'Are you able to move without difficulty?'
        },
        {
          'quizId': quizId,
          'questionTitle': 'Are there other people with you who need help?'
        },
        {
          'quizId': quizId,
          'questionTitle': 'Can you safely reach a window or balcony?'
        }
      ];
      for(final question in questions){
        final questionId = await db.insert('question', question);
        questionIds.add(questionId);
      }
      List<int> emergencyActionIds = [];
      final List<Map<String, dynamic>> emergencyActions = 
      [
        {
          'actionTitle': 'Basement Fire Risk',
          'actionDescription':
              'Basements fill with smoke quickly. Stay low, block smoke with cloth, and signal for help immediately. Call emergency services if possible.',
          'LevelOfDanger': 'High',
        },
        {
          'actionTitle': 'Injured and Cannot Move',
          'actionDescription':
              'Do not attempt to move if it is unsafe. Stay low, protect your airway from smoke, and call emergency services. Signal your location if possible.',
          'LevelOfDanger': 'High',
        },
        {
          'actionTitle': 'Others Need Assistance',
          'actionDescription':
              'If safe, assist others to move together. If not safe, call emergency services immediately and report their location.',
          'LevelOfDanger': 'Medium',
        },
        {
          'actionTitle': 'Exit Safely',
          'actionDescription':
              'Leave the building immediately using the stairs. Move to a safe open area away from the building and wait for help.',
          'LevelOfDanger': 'Low',
        },
        {
          'actionTitle': 'Signal from Window or Balcony',
          'actionDescription':
              'Go to the window or balcony, close doors behind you, block smoke, and signal for help. Do not jump unless instructed by rescuers.',
          'LevelOfDanger': 'High',
        },
        {
          'actionTitle': 'No Safe Escape',
          'actionDescription':
              'Stay in the safest room available. Seal doors with cloth to block smoke, stay low, and signal for help. Call emergency services immediately.',
          'LevelOfDanger': 'High',
        },
      ];
      for(final action in emergencyActions){
        final emergencyActionId = await db.insert('emergencyAction', action);
        emergencyActionIds.add(emergencyActionId);
      }
      final List<Map<String, dynamic>> answers = [

      // Question 1: What floor are you currently on?
      {
        'questionId': questions[0],
        'answerTitle': 'Ground floor',
        'nextQuestionId': questions[2],
        'emergencyActionId': null,
      },
      {
        'questionId': questions[0],
        'answerTitle': 'Upper floor',
        'nextQuestionId': questions[7],
        'emergencyActionId': null,
      },
      {
        'questionId': questions[0],
        'answerTitle': 'Basement',
        'nextQuestionId': null,
        'emergencyActionId': emergencyActionIds[0],
      },

      // Question 2: Is there heavy smoke in your current location?
      {
        'questionId': questions[1],
        'answerTitle': 'Yes, thick smoke is present',
        'nextQuestionId': questions[3],
        'emergencyActionId': null,
      },
      {
        'questionId': questions[1],
        'answerTitle': 'Some smoke but still visible',
        'nextQuestionId': questions[2],
        'emergencyActionId': null,
      },
      {
        'questionId': questions[1],
        'answerTitle': 'No smoke at the moment',
        'nextQuestionId': questions[2],
        'emergencyActionId': null,
      },

      // Question 3: Is the exit door near you blocked?
      {
        'questionId': questions[2],
        'answerTitle': 'Yes, it is blocked',
        'nextQuestionId': questions[7],
        'emergencyActionId': null,
      },
      {
        'questionId': questions[2],
        'answerTitle': 'Partially blocked',
        'nextQuestionId': questions[3],
        'emergencyActionId': null,
      },
      {
        'questionId': questions[2],
        'answerTitle': 'No, it is clear',
        'nextQuestionId': questions[4],
        'emergencyActionId': null,
      },

      // Question 4: Does the door feel hot?
      {
        'questionId': questions[3],
        'answerTitle': 'Yes, it feels very hot',
        'nextQuestionId': questions[7],
        'emergencyActionId': null,
      },
      {
        'questionId': questions[3],
        'answerTitle': 'Warm but not hot',
        'nextQuestionId': questions[4],
        'emergencyActionId': null,
      },
      {
        'questionId': questions[3],
        'answerTitle': 'No, it feels normal',
        'nextQuestionId': questions[4],
        'emergencyActionId': null,
      },

      // Question 5: Is there a staircase available nearby?
      {
        'questionId': questions[4],
        'answerTitle': 'Yes, I can access the stairs',
        'nextQuestionId': questions[5],
        'emergencyActionId': null,
      },
      {
        'questionId': questions[4],
        'answerTitle': 'No, stairs are not accessible',
        'nextQuestionId': questions[7],
        'emergencyActionId': null,
      },

      // Question 6: Are you able to move without difficulty?
      {
        'questionId': questions[5],
        'answerTitle': 'Yes, I can move normally',
        'nextQuestionId': questions[6],
        'emergencyActionId': null,
      },
      {
        'questionId': questions[5],
        'answerTitle': 'I am injured or weak',
        'nextQuestionId': null,
        'emergencyActionId': emergencyActionIds[1],
      },

      // Question 7: Are there other people with you?
      {
        'questionId': questions[6],
        'answerTitle': 'Yes, there are others with me',
        'nextQuestionId': null,
        'emergencyActionId': emergencyActionIds[2],
      },
      {
        'questionId': questions[6],
        'answerTitle': 'No, I am alone',
        'nextQuestionId': null,
        'emergencyActionId': emergencyActionIds[3],
      },

      // Question 8: Can you reach a window or balcony?
      {
        'questionId': questions[7],
        'answerTitle': 'Yes, I can reach a window or balcony',
        'nextQuestionId': null,
        'emergencyActionId': emergencyActionIds[4],
      },
      {
        'questionId': questions[7],
        'answerTitle': 'No, there is no safe access',
        'nextQuestionId': null,
        'emergencyActionId': emergencyActionIds[5],
      },
    ];
    for(var answer in answers){
      await db.insert('answer', answer);
    }
  }
}