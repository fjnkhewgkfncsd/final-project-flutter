import '../interface/Irepository.interface.dart';
import '../model/question.model.dart';

class QuestionService {
  final IQuestionRepo _questionRepo;

  QuestionService(this._questionRepo);

  Future<Question?> getQuestionById(int id) async {
    return await _questionRepo.getById(id);
  }

  Future<List<Question>> getQuestionsByQuizId(int quizId) async {
    return await _questionRepo.getQuestionsByQuizId(quizId);
  }
}
