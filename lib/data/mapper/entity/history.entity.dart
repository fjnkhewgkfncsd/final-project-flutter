class HistoryEntity {
  final int id;
  final int quizId; 
  final DateTime timestamp;

  const HistoryEntity({
    required this.id,
    required this.quizId,
    required this.timestamp,
  });
  factory HistoryEntity.fromMap(Map<String, dynamic> map) {
    return HistoryEntity(
      id: map['id'],
      quizId: map['quizId'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}