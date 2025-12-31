import '../entity/history.entity.dart';
import '../../domain/model/history.model.dart';

class HistoryMapper {
  static History toModel(HistoryEntity entity) {
    return History(
      id: entity.id,
      quizId: entity.quizId,
      timestamp: entity.timestamp,
    );
  }

  static HistoryEntity toEntity(History model) {
    return HistoryEntity(
      id: model.id,
      quizId: model.quizId,
      timestamp: model.timestamp,
    );
  }
}