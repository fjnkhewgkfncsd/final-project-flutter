import './question.entity.dart';
import 'choice.entity.dart';
class QuizEntity{
  final int id;
  final List<QuestionEntity> questions;
  final int startQuestionId;

  const QuizEntity({
    required this.id,
    required this.startQuestionId,
    this.questions = const [],
  });

  factory QuizEntity.fromMap(Map<String, dynamic> map) {
    return QuizEntity(
      id: map['quizId'] as int,
      startQuestionId: map['startQuestion'] as int,
      questions: [],
    );
  }
  //extracts quiz with questions and answers from a joined map
  factory QuizEntity.fromMapWithQuestions(List<Map<String, dynamic>> rows) {
    final Map<int,QuestionEntity> questions = {};
    for (final row in rows) {
      final qId = row['questionId'] as int;
      questions.putIfAbsent(qId, () {
        return QuestionEntity.fromMap(
          row
        );
      });

      questions[qId]!.choices.add(
        ChoiceEntity.fromMap(
          row
        )
      );
    }

  return QuizEntity(
    id: rows.first['quizId'] as int,
    startQuestionId: rows.first['startQuestion'] as int,
    questions: questions.values.toList(),
  );
  }
}