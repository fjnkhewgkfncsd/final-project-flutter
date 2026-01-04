class History {
  final int id;
  final int quizId;
  final DateTime timestamp;
  bool isFav;

  History({
    required this.id,
    required this.quizId,
    required this.timestamp,
    this.isFav = false,
  });
}