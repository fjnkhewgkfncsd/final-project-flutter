import 'emergencyAction.entity.dart';
class AnswerEntity {
  final int answerId;
  final String answerTitle;
  final int? nextQuestionId;
  final EmergencyActionEntity? emergencyAction;
  final int questionId;

  const AnswerEntity({
    required this.answerId,
    required this.answerTitle,
    this.nextQuestionId,
    this.emergencyAction,
    required this.questionId,
  });

  factory AnswerEntity.fromMap(Map<String, dynamic> map) {
    int emergencyActionId = map['emergencyActionId'];
    String emergencyActionTitle = map['actionTitle'];
    String instructor = map['instruction'];
    String level = map['level'];
    return AnswerEntity(
      answerId: map['answerId'] as int,
      answerTitle: map['answerTitle'] as String,
      nextQuestionId: map['nextQuestionId'] as int?,
      emergencyAction: EmergencyActionEntity(id: emergencyActionId, actionTitle: emergencyActionTitle, instruction: instructor, level: level),
      questionId: map['questionId'] as int,
    );
  }
}