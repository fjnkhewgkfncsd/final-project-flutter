import 'answer.entity.dart';
class QuestionEntity {
  final int questionId;
  final String questionTitle;
  final int quizId;
  final List<AnswerEntity> answers ;

  QuestionEntity({
    required this.questionId,
    required this.questionTitle,
    required this.quizId,
    this.answers = const [],
  });

  factory QuestionEntity.fromMap(Map<String, dynamic> map) {
    return QuestionEntity(
      questionId: map['questionId'] as int,
      questionTitle: map['questionTitle'] as String,
      quizId: map['quizId'] as int,
    );
  }
}