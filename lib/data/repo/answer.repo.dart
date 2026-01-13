import '../../domain/interface/Irepository.interface.dart';
import '../mapper/choice.mapper.dart';
import '../service/controller/choice.controller.dart';
import '../../domain/model/choice.model.dart';

class AnswerRepoImpl implements IAnswerRepo {
  final AnswerController _answerController = AnswerController();

  @override
  Future<Choice?> getById(int id) async {
    final result = await _answerController.getAnswerById(id);
    return result == null ? null : ChoiceMapper.toDomain(result);
  }

  @override
  Future<List<Choice>> getAnswersByQuestionId(int questionId) async {
    final results = await _answerController.getAnswersByQuestionId(questionId);
    return results.map((entity) => ChoiceMapper.toDomain(entity)).toList();
  }

  @override
  Future<List<Choice>> getAnswersByHistoryId(int historyId) async {
    final results = await _answerController.getAnswersByHistoryId(historyId);
    return results.map((entity) => ChoiceMapper.toDomain(entity)).toList();
  }
}