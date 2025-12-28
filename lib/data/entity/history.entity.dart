class History {
  final int id;
  final int quizId;

  const History({
    required this.id,
    required this.quizId,
  });
  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      id: map['id'],
      quizId: map['quizId'],
    );
  }
}