import '../entity/userAnswer.entity.dart';
import '../../domain/model/userAnswer.model.dart';
class UserAnswerMapper {
  static UserAnswer toDomain(UserAnswerEntity entity) {
    return UserAnswer(
      id: entity.id,
      answerId : entity.answerId,
      quizId : entity.quizId,
      historyId : entity.historyId,
    );
  }
  static UserAnswerEntity toEntity(UserAnswer domain) {
    return UserAnswerEntity(
      id: domain.id,
      answerId: domain.answerId,
      quizId: domain.quizId,
      historyId: domain.historyId,
    );
  }
}