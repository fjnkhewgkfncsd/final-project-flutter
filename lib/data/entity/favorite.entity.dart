import './history.entity.dart';
class FavoriteEntity {
  final int? favId;
  final HistoryEntity history;

  const FavoriteEntity({
    required this.favId,
    required this.history,
  });

  factory FavoriteEntity.fromMap(Map<String, dynamic> map) {
    final HistoryEntity history =
        HistoryEntity.fromMap(map, includeFavorite: false);

    return FavoriteEntity(
      favId: map['favoriteId'] ?? map['id'],
      history: history,
    );
  }
}