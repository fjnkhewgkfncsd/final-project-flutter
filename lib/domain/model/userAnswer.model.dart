class UserAnswer {
  final int? id;
  final int answerId;
  final int quizId;
  final int historyId;

  const UserAnswer({
    this.id,
    required this.answerId,
    required this.quizId,
    required this.historyId,
  });

  factory UserAnswer.toDB({required int answerId, required int quizId,required int historyId}) {
    return UserAnswer(
      answerId: answerId,
      quizId: quizId,
      historyId: historyId,
    );
  }
}