import './question.model.dart';
class Quiz{
  final int id;
  final int emergencyId;
  final List<Question> questions;

  const Quiz({
    required this.id,
    required this.emergencyId,
    required this.questions,
  });
}