class UserAnswer {
  final int id;
  final int answerId;
  final int quizId;
  final int historyId;

  const UserAnswer({
    required this.id,
    required this.answerId,
    required this.quizId,
    required this.historyId,
  });
  factory UserAnswer.fromMap(Map<String, dynamic> map) {
    return UserAnswer(
      id: map['id'],
      answerId: map['answerId'],
      quizId: map['quizId'],
      historyId: map['historyId'],
    );
  }
}