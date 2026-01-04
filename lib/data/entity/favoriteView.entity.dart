class FavoriteViewEntity{
  final int id;
  final int quizId;
  final String icon;
  final String title;
  final DateTime timestamp;
  final String category;

  const FavoriteViewEntity({
    required this.id,
    required this.quizId,
    required this.icon,
    required this.title,
    required this.timestamp,
    required this.category,
  });

  factory FavoriteViewEntity.fromMap(Map<String, dynamic> map) {
    return FavoriteViewEntity(
      id: map['id'],
      quizId: map['quizId'],
      icon: map['emergencyIcon'],
      title: map['emergencyName'],
      timestamp: DateTime.parse(map['timestamp']),
      category: map['categoryName'],
    );
  }
}