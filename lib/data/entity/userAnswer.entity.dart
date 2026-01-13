import './choice.entity.dart';
class UserAnswerEntity {
  final int? id;
  final ChoiceEntity choice;
  final int historyId;

  const UserAnswerEntity({
    this.id,
    required this.choice,
    required this.historyId,
  });
  factory UserAnswerEntity.fromMap(Map<String, dynamic> map) {
    return UserAnswerEntity(
      id: map['id'],
      choice: ChoiceEntity.fromMap(map),
      historyId: map['historyId'],
    );
  }
}