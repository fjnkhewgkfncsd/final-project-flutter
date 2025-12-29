import '../interface/Irepository.interface.dart';
import '../model/quiz.model.dart';

class QuizService {
  final IQuizRepo _quizRepo;

  QuizService(this._quizRepo);

  Future<Quiz?> getQuizById(int id) async {
    return await _quizRepo.getById(id);
  }

  Future<Quiz?> getQuizByEmergencyId(int emergencyId) async {
    return await _quizRepo.getQuizByEmergencyId(emergencyId);
  }

  Future<Quiz?> getQuizWithQuestionsAndAnswers(int emergencyId) async {
    return await _quizRepo.getQuizWithQuestionsAndAnswers(emergencyId);
  }
}