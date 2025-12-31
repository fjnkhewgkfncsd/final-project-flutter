import '../mapper/question.mapper.dart';
import '../../domain/interface/Irepository.interface.dart';
import '../../domain/model/question.model.dart';
import '../service/controller/question.controller.dart';

class QuestionRepoImpl implements IQuestionRepo {
  final QuestionController _questionController = QuestionController();

  @override
  Future<Question?> getById(int id) async {
    final result = await _questionController.getQuestionById(id);
    return result == null ? null : QuestionMapper.toDomain(result);
  }

  @override
  Future<List<Question>> getQuestionsByQuizId(int quizId) async {
    final results = await _questionController.getQuestionsByQuizId(quizId);
    return results.map((entity) => QuestionMapper.toDomain(entity)).toList();
  }

  Future<List<Question>> getQuestionsWithAnswersByQuizId(int quizId) async {
    final results = await _questionController.getQuestionsWithAnswersByQuizId(quizId);
    return results.map((entity) => QuestionMapper.toDomain(entity)).toList();
  }
}