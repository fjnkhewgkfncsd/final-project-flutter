import './userAnswer.model.dart';
import './emergency.model.dart';
import './favorite.model.dart';
class History {
  final int id;
  final DateTime timestamp;
  final List<UserAnswer> userAnswers;
  final Emergency emergency;
  Favorite? favorite;
  bool isFav = false;

  History({
    required this.id,
    required this.timestamp,
    required this.userAnswers,
    required this.emergency,
    this.favorite,
  });
}