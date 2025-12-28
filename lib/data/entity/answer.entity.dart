class Answer {
  final int answerId;
  final String answerTitle;
  final int? nextQuestionId;
  final int? emergencyActionId;
  final int questionId;

  const Answer({
    required this.answerId,
    required this.answerTitle,
    this.nextQuestionId,
    this.emergencyActionId,
    required this.questionId,
  });

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      answerId: map['answerId'],
      answerTitle: map['answerTitle'],
      nextQuestionId: map['nextQuestionId'],
      emergencyActionId: map['emergencyActionId'],
      questionId: map['questionId'],
    );
  }
}