class Quiz{
  final int id;
  final int emergencyId;

  const Quiz({
    required this.id,
    required this.emergencyId,
  });

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      id: map['quizId'],
      emergencyId: map['emergencyId'],
    );
  }
}