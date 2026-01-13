import '../entity/choice.entity.dart';
import '../../domain/model/choice.model.dart';
import '../mapper/emergencyAction.mapper.dart';

class ChoiceMapper {
  static Choice toDomain(ChoiceEntity entity) {
    return Choice(
      choiceId: entity.choiceId,
      choiceTitle: entity.choiceTitle,
      nextQuestionId: entity.nextQuestionId,
      emergencyAction: entity.emergencyAction == null ? null : EmergencyActionMapper.toDomain(entity.emergencyAction!),
    );
  }

  static ChoiceEntity toEntity(Choice domain) {
    return ChoiceEntity(
      choiceId: domain.choiceId,
      choiceTitle: domain.choiceTitle,
      nextQuestionId: domain.nextQuestionId,
      emergencyAction: EmergencyActionMapper.toEntity(domain.emergencyAction),
    );
  }
}