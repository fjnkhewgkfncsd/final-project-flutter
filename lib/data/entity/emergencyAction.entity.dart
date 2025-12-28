class EmergencyAction {
  final int id;
  final String actionTitle;
  final String instruction;
  final String level;

  const EmergencyAction({
    required this.id,
    required this.actionTitle,
    required this.instruction,
    required this.level,
  });

  factory EmergencyAction.fromMap(Map<String, dynamic> map) {
    return EmergencyAction(
      id: map['id'],
      actionTitle: map['actionTitle'],
      instruction: map['instruction'],
      level: map['level'],
    );
  }
}