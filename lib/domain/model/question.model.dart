import 'choice.model.dart';
class Question {
  final int questionId;
  final String questionTitle;
  final List<Choice> choices;

  Question({
    required this.questionId,
    required this.questionTitle,
    required this.choices,
  });
}