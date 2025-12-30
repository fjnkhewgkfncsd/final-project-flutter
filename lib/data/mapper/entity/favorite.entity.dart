class FavoriteEntity {
  final int id;
  final int historyId;

  const FavoriteEntity({
    required this.id,
    required this.historyId,
  });
  factory FavoriteEntity.fromMap(Map<String, dynamic> map) {
    return FavoriteEntity(
      id: map['id'],
      historyId: map['historyId'],
    );
  }
}