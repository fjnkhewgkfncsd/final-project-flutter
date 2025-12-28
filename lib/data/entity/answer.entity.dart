class AnswerEntity {
  final int answerId;
  final String answerTitle;
  final int? nextQuestionId;
  final int? emergencyActionId;
  final int questionId;

  const AnswerEntity({
    required this.answerId,
    required this.answerTitle,
    this.nextQuestionId,
    this.emergencyActionId,
    required this.questionId,
  });

  factory AnswerEntity.fromMap(Map<String, dynamic> map) {
    return AnswerEntity(
      answerId: map['answerId'] as int,
      answerTitle: map['answerTitle'] as String,
      nextQuestionId: map['nextQuestionId'] as int?,
      emergencyActionId: map['emergencyActionId'] as int?,
      questionId: map['questionId'] as int,
    );
  }
}