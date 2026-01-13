import 'choice.entity.dart';
class QuestionEntity {
  final int questionId;
  final String questionTitle;
  final List<ChoiceEntity> choices ;

  QuestionEntity({
    required this.questionId,
    required this.questionTitle,
    List<ChoiceEntity>? choices,
  }) : choices = choices ?? [];

  factory QuestionEntity.fromMap(Map<String, dynamic> map) {
    return QuestionEntity(
      questionId: map['questionId'] as int,
      questionTitle: map['questionTitle'] as String,
    );
  }
}