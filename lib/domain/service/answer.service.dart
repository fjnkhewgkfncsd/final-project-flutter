import '../interface/Irepository.interface.dart';
import '../model/answer.model.dart';

class AnswerService {
  final IAnswerRepo _answerRepo;

  AnswerService(this._answerRepo);

  Future<List<Answer>> getAllAnswers(int id) async {
    return await _answerRepo.getAnswersByQuestionId(id);
  }

  Future<Answer?> getAnswerById(int id) async {
    return await _answerRepo.getById(id);
  }
}