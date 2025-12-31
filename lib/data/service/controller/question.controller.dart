import '../../entity/question.entity.dart';
import '../db/database.service.dart';
import '../../entity/answer.entity.dart';
class QuestionController {
  final DataBaseService _databaseService = DataBaseService();

  Future<List<QuestionEntity>> getQuestionsWithAnswersByQuizId(int quizId) async {
  final db = await _databaseService.database;

  final rows = await db.rawQuery(
    '''
    SELECT
      q.*,
      a.answerId,
      a.answerText,
      a.nextQuestionId
    FROM question q
    JOIN answer a ON q.questionId = a.questionId
    WHERE q.quizId = ?
    ''',
    [quizId],
  );

  final Map<int, QuestionEntity> questions = {};

  for (final row in rows) {
    final qId = row['questionId'] as int;
    questions.putIfAbsent(qId, () {
      return QuestionEntity.fromMap(
        row
      );
    });

    questions[qId]!.answers.add(
      AnswerEntity.fromMap(
        row
      )
    );
  }

  return questions.values.toList();
}

  Future<QuestionEntity?> getQuestionById(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'question',
      where: 'questionId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return QuestionEntity.fromMap(maps.first);
    }
    return null;
  }

  Future<List<QuestionEntity>> getQuestionsByQuizId(int quizId) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'question',
      where: 'quizId = ?',
      whereArgs: [quizId],
    );
    return maps.map((map) => QuestionEntity.fromMap(map)).toList();
  }
}