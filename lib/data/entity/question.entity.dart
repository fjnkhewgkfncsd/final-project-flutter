class Question {
  final int questionId;
  final String questionTitle;
  final int quizId;

  const Question({
    required this.questionId,
    required this.questionTitle,
    required this.quizId,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionId: map['questionId'],
      questionTitle: map['questionTitle'],
      quizId: map['quizId'],
    );
  }
}