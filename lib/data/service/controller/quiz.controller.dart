import '../../entity/quiz.entity.dart';
import '../db/database.service.dart';
class QuizController {
  final DataBaseService _databaseService = DataBaseService();

  Future<QuizEntity?> getQuizByEmergencyId(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'quiz',
      where: 'emergencyId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return QuizEntity.fromMap(maps.first);
    }
    return null;
  }

  Future<QuizEntity?> getQuizWithQuestionsAndAnswers(int emergencyId) async {
    final db = await _databaseService.database;

    final rows = await db.rawQuery(
      '''
      SELECT
        qz.quizId,
        qz.emergencyId,
        q.questionId,
        q.questionTitle,
        a.answerId,
        a.answerText,
        a.nextQuestionId,
        ea.*
      FROM quiz qz
      JOIN question q ON qz.quizId = q.quizId
      JOIN answer a ON q.questionId = a.questionId
      JOIN emergencyAction ea on a.emergencyActionId = ea.emergencyActionId
      WHERE qz.emergencyId = ?
      ''',
      [emergencyId],
    );

    if (rows.isEmpty) {
      return null;
    }

    return QuizEntity.fromMapWithQuestions(rows);
  }
}