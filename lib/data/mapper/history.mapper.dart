import '../entity/history.entity.dart';
import '../../domain/model/history.model.dart';
import './userAnswer.mapper.dart';
import './emergency.mapper.dart';
import './favorite.mapper.dart';
class HistoryMapper {
  static History toModel(HistoryEntity entity) {
    return History(
      id: entity.id,
      timestamp: entity.timestamp,
      userAnswers: entity.userAnswers.map((uaEntity) => UserAnswerMapper.toDomain(uaEntity)).toList(),
      emergency: EmergencyMapper.toDomain(entity.emergency),
      favorite: entity.favorite != null ? FavoriteMapper.toDomain(entity.favorite!) : null,
    );
  }

  // static HistoryEntity toEntity(History model) {
  //   return HistoryEntity(
  //     id: model.id,
  //     quizId: model.quizId,
  //     timestamp: model.timestamp,
  //     userAnswers: model.userAnswers.map((uaModel) => UserAnswerMapper.toEntity(uaModel)).toList(),
  //   );
  // }
}