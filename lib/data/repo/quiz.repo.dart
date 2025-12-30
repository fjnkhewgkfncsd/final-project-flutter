import '../../domain/interface/Irepository.interface.dart';
import '../../domain/model/quiz.model.dart';
import '../service/controller/quiz.controller.dart';
import '../mapper/quiz.mapper.dart';

class QuizRepoImpl implements IQuizRepo {
  final QuizController _quizController = QuizController();

  @override
  Future<Quiz?> getById(int id) async {
    final result = await _quizController.getQuizById(id);
    return result == null ? null : QuizMapper.toDomain(result);
  }

  @override
  Future<Quiz?> getQuizByEmergencyId(int emergencyId) async {
    final result = await _quizController.getQuizByEmergencyId(emergencyId);
    return result == null ? null : QuizMapper.toDomain(result);
  }

  @override
  Future<Quiz?> getQuizWithQuestionsAndAnswers(int emergencyId) async {
    final result = await _quizController.getQuizWithQuestionsAndAnswers(emergencyId);
    return result == null ? null : QuizMapper.toDomain(result);
  }
}