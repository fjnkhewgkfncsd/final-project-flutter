class HistoryEntity {
  final int id;
  final int quizId;

  const HistoryEntity({
    required this.id,
    required this.quizId,
  });
  factory HistoryEntity.fromMap(Map<String, dynamic> map) {
    return HistoryEntity(
      id: map['id'],
      quizId: map['quizId'],
    );
  }
}