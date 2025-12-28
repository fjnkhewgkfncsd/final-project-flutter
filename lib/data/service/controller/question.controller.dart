import '../../entity/question.entity.dart';
import '../db/database.service.dart';
import '../../entity/answer.entity.dart';
class QuestionController {
  final DataBaseService _databaseService = DataBaseService();

  Future<List<QuestionEntity>> getQuestionsWithAnswers(int quizId) async {
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

}