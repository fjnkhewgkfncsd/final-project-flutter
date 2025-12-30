class UserAnswerEntity {
  final int id;
  final int answerId;
  final int quizId;
  final int historyId;

  const UserAnswerEntity({
    required this.id,
    required this.answerId,
    required this.quizId,
    required this.historyId,
  });
  factory UserAnswerEntity.fromMap(Map<String, dynamic> map) {
    return UserAnswerEntity(
      id: map['id'],
      answerId: map['answerId'],
      quizId: map['quizId'],
      historyId: map['historyId'],
    );
  }
}