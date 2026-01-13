import '../interface/Irepository.interface.dart';
import '../model/choice.model.dart';

class AnswerService {
  final IAnswerRepo _answerRepo;

  AnswerService(this._answerRepo);

  Future<List<Choice>> getAllAnswers(int id) async {
    return await _answerRepo.getAnswersByQuestionId(id);
  }

  Future<Choice?> getAnswerById(int id) async {
    return await _answerRepo.getById(id);
  }
  Future<List<Choice>> getAnswersByHistoryId(int historyId) async {
    return await _answerRepo.getAnswersByHistoryId(historyId);
  }
}