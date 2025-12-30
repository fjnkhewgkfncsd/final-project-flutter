import 'entity/emergencyAction.entity.dart';
import '../../domain/model/emergencyAction.model.dart';

class EmergencyActionMapper {
  static EmergencyAction toDomain(EmergencyActionEntity entity) {
    return EmergencyAction(
      id: entity.id,
      actionTitle: entity.actionTitle,
      instruction: entity.instruction,
      level: entity.level,
    );
  }

  static EmergencyActionEntity? toEntity(EmergencyAction? domain) {
    if (domain == null) return null;
    return EmergencyActionEntity(
      id: domain.id,
      actionTitle: domain.actionTitle,
      instruction: domain.instruction,
      level: domain.level,
    );
  }
}