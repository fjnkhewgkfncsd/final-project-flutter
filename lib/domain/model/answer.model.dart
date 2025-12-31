import './emergencyAction.model.dart';
class Answer {
  final int answerId;
  final String answerTitle;
  final int? nextQuestionId;
  final EmergencyAction? emergencyAction;
  final int questionId;

  const Answer({
    required this.answerId,
    required this.answerTitle,
    this.nextQuestionId,
    this.emergencyAction,
    required this.questionId,
  });
}