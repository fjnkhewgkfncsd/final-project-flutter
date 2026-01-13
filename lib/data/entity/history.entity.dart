import './userAnswer.entity.dart';
import './emergency.entity.dart';
import './favorite.entity.dart';

class HistoryEntity {
  final int id;
  final DateTime timestamp;
  final List<UserAnswerEntity> userAnswers;
  final EmergencyEntity emergency;
  final FavoriteEntity? favorite;

  const HistoryEntity({
    required this.id,
    required this.timestamp,
    required this.userAnswers,
    required this.emergency,
    this.favorite,
  });

  factory HistoryEntity.fromMap(
    Map<String, dynamic> map, {
    bool includeFavorite = true,
  }) {
    final dynamic tsValue = map['timestamp'];
    final DateTime parsedTimestamp;
    if (tsValue is int) {
      parsedTimestamp = DateTime.fromMillisecondsSinceEpoch(tsValue);
    } else {
      parsedTimestamp = DateTime.parse(tsValue.toString());
    }
    return HistoryEntity(
      id: map['historyId'],
      userAnswers: [],
      timestamp: parsedTimestamp,
      emergency: EmergencyEntity.fromMapWithCategory(map),
        favorite: includeFavorite && map['favoriteId'] != null
          ? FavoriteEntity.fromMap(map)
          : null,
    );
  }
}