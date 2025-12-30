import 'question.entity.dart';
import 'answer.entity.dart';
class QuizEntity{
  final int id;
  final int emergencyId;
  final List<QuestionEntity> questions;

  const QuizEntity({
    required this.id,
    required this.emergencyId,
    this.questions = const [],
  });

  factory QuizEntity.fromMap(Map<String, dynamic> map) {
    return QuizEntity(
      id: map['quizId'] as int,
      emergencyId: map['emergencyId'] as int,
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

    questions[qId]!.answers.add(
      AnswerEntity.fromMap(
        row
      )
    );
  }

  return QuizEntity(
    id: rows.first['quizId'] as int,
    emergencyId: rows.first['emergencyId'] as int,
    questions: questions.values.toList(),
  );
  }
}