import './emergencyAction.model.dart';
class Choice {
  final int choiceId;
  final String choiceTitle;
  final int? nextQuestionId;
  final EmergencyAction? emergencyAction;
  // final int questionId;

  const Choice({
    required this.choiceId,
    required this.choiceTitle,
    this.nextQuestionId,
    this.emergencyAction,
    // required this.questionId,
  });
}