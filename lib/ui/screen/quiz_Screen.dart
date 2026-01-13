import 'package:flutter/material.dart';

import '../../domain/service/quiz.service.dart';
import '../../data/repo/quiz.repo.dart';
import '../../domain/model/quiz.model.dart';

import '../screen/start_Screen.dart';

import '../widget/question.widget.dart';
import '../../domain/model/question.model.dart';

import './emergencyAction.screen.dart';

import '../../data/repo/history.repo.dart';
import '../../domain/service/history.service.dart';

import '../../domain/model/userAnswer.model.dart';
import '../../domain/service/userAnswer.service.dart';
import '../../data/repo/userAnswer.repo.dart';
import '../../domain/model/emergency.model.dart';
import '../../domain/model/choice.model.dart';

class QuizScreen extends StatefulWidget {
  final Emergency emergency;

  const QuizScreen({
    super.key,
    required this.emergency,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Choice> userAnswers = [];

  late final QuizService _quizService;
  late Quiz _quiz;

  int currentQuestionId = 0;

  bool isLoading = true;

  final HistoryService _historyService =
      HistoryService(HistoryRepoImpl());

  final UserAnswerService _userAnswerService = UserAnswerService(UserAnswerRepoImpl());

  Quiz get defaultQuiz => Quiz(id: 0, startQuestionId: 0, questions: []);

  @override
  void initState() {
    super.initState();
    _quizService = QuizService(QuizRepoImpl());
    _loadQuiz();
  }

  Future<void> _loadQuiz() async {
    _quiz = await _quizService
            .getQuizWithQuestionsAndAnswers(widget.emergency.id)
        ?? defaultQuiz;

    setState(() {
      isLoading = false;
      currentQuestionId = _quiz.startQuestionId;
    });
  }

  Question getQuestionById(int questionId) {
    return _quiz.questions.firstWhere(
      (q) => q.questionId == questionId,
    );
  }

  Choice getAnswerById(int answerId) {
    return _quiz.questions
        .expand((q) => q.choices)
        .firstWhere((a) => a.choiceId == answerId);
  }

  Future<int> insertHistory() async {
    return await _historyService.addHistory(widget.emergency.id);
  }

  Future<void> insertUserAnswersToDb(int historyId) async {
    for (final answerId in userAnswers) {
      await _userAnswerService.insertUserAnswer(
        UserAnswer.toDB(
          historyId: historyId,
          choice: answerId,
        ),
      );
    }
  }

  void addUserAnswer(Choice choice) async {
    userAnswers.add(choice);
    final nextQuestionId = choice.nextQuestionId;
    if (nextQuestionId == null){
      final historyId = await insertHistory();
      await insertUserAnswersToDb(historyId);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => EmergencyActionScreen(
            historyId: historyId,
            isFromQuiz: true,
            emergency: choice.emergencyAction!,
          ),
        ),
      );
      return;
    }
    setState(() {
      currentQuestionId = nextQuestionId;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const StartScreen();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(widget.emergency.name),
      ),
      body: QuestionWidget(
        question: getQuestionById(currentQuestionId),
        returnAnswerId: addUserAnswer,
      ),
    );
  }
}
