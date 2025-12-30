import '../../domain/interface/Irepository.interface.dart';
import '../mapper/answer.mapper.dart';
import '../service/controller/answer.controller.dart';
import '../../domain/model/answer.model.dart';

class AnswerRepoImpl implements IAnswerRepo {
  final AnswerController _answerController = AnswerController();

  @override
  Future<Answer?> getById(int id) async {
    final result = await _answerController.getAnswerById(id);
    return result == null ? null : AnswerMapper.toDomain(result);
  }

  @override
  Future<List<Answer>> getAnswersByQuestionId(int questionId) async {
    final results = await _answerController.getAnswersByQuestionId(questionId);
    return results.map((entity) => AnswerMapper.toDomain(entity)).toList();
  }
}