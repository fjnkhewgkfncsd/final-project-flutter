import './answer.model.dart';
class Question {
  final int questionId;
  final String questionTitle;
  final int quizId;
  final List<Answer> answers;

  Question({
    required this.questionId,
    required this.questionTitle,
    required this.quizId,
    required this.answers,
  });
}