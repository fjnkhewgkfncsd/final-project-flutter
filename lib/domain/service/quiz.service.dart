import '../interface/Irepository.interface.dart';
import '../model/quiz.model.dart';

class QuizService {
  final IQuizRepo _quizRepo;

  QuizService(this._quizRepo);

  Future<Quiz?> getQuizById(int id) async {
    return await _quizRepo.getById(id);
  }
}