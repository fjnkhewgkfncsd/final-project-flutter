import './choice.model.dart';
class UserAnswer {
  final int? id;
  final Choice choice;
  final int historyId;

  const UserAnswer({
    this.id,
    required this.choice,
    required this.historyId,
  });

  factory UserAnswer.toDB({required Choice choice, required int historyId}) {
    return UserAnswer(
      choice: choice,
      historyId: historyId,
    );
  }
}