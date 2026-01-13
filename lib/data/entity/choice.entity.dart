import './emergencyAction.entity.dart';
class ChoiceEntity {
  final int choiceId;
  final String choiceTitle;
  final int? nextQuestionId;
  final EmergencyActionEntity? emergencyAction;

  const ChoiceEntity({
    required this.choiceId,
    required this.choiceTitle,
    this.nextQuestionId,
    this.emergencyAction,
  });

  factory ChoiceEntity.fromMap(Map<String, dynamic> map) {
    int? emergencyActionId = map['emergencyActionId'];
    String? emergencyActionTitle = map['actionTitle'];
    String? instructor = map['instruction'];
    String? level = map['LevelOfDanger'];
    if(emergencyActionId == null){
      return ChoiceEntity(
        choiceId: map['answerId'] as int,
        choiceTitle: map['answerTitle'] as String,
        nextQuestionId: map['nextQuestionId'] as int?,
      );
    }
    return ChoiceEntity(
      choiceId: map['answerId'] as int,
      choiceTitle: map['answerTitle'] as String,
      nextQuestionId: map['nextQuestionId'] as int?,
      emergencyAction: EmergencyActionEntity(id: emergencyActionId, actionTitle: emergencyActionTitle!, instruction: instructor!, level: level!),
    );
  }
}