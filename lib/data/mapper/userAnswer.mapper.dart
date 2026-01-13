import '../entity/userAnswer.entity.dart';
import '../../domain/model/userAnswer.model.dart';
import './choice.mapper.dart';
class UserAnswerMapper {
  static UserAnswer toDomain(UserAnswerEntity entity) {
    return UserAnswer(
      id: entity.id,
      choice: ChoiceMapper.toDomain(entity.choice),
      historyId : entity.historyId,
    );
  }
  static UserAnswerEntity toEntity(UserAnswer domain) {
    return UserAnswerEntity(
      choice: ChoiceMapper.toEntity(domain.choice),
      historyId: domain.historyId,
    );
  }
}