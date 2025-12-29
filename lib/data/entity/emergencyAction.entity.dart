class EmergencyActionEntity {
  final int id;
  final String actionTitle;
  final String instruction;
  final String level;

  const EmergencyActionEntity({
    required this.id,
    required this.actionTitle,
    required this.instruction,
    required this.level,
  });

  factory EmergencyActionEntity.fromMap(Map<String, dynamic> map) {
    return EmergencyActionEntity(
      id: map['id'],
      actionTitle: map['actionTitle'],
      instruction: map['instruction'],
      level: map['level'],
    );
  }
}