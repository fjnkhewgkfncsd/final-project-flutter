import '../entity/answer.entity.dart';
import '../../domain/model/answer.model.dart';
import '../mapper/emergencyAction.mapper.dart';

class AnswerMapper {
  static Answer toDomain(AnswerEntity entity) {
    return Answer(
      answerId: entity.answerId,
      answerTitle: entity.answerTitle,
      nextQuestionId: entity.nextQuestionId,
      emergencyAction: entity.emergencyAction == null ? null : EmergencyActionMapper.toDomain(entity.emergencyAction!),
      questionId: entity.questionId,
    );
  }

  static AnswerEntity toEntity(Answer domain) {
    return AnswerEntity(
      answerId: domain.answerId,
      answerTitle: domain.answerTitle,
      nextQuestionId: domain.nextQuestionId,
      emergencyAction: EmergencyActionMapper.toEntity(domain.emergencyAction),
      questionId: domain.questionId,
    );
  }
}