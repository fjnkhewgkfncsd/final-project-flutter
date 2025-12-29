import '../../domain/interface/Irepository.interface.dart';
import '../../domain/model/userAnswer.model.dart';
import '../service/controller/userAnswer.controller.dart';
import '../mapper/userAnswer.mapper.dart';

class UserAnswerRepoImpl implements IUserAnswerRepo {
  final UserAnswerController _userAnswerController = UserAnswerController();

  @override
  Future<UserAnswer?> getById(int id) async {
    final result = await _userAnswerController.getUserAnswerById(id);
    return result == null ? null : UserAnswerMapper.toDomain(result);
  }

  @override
  Future<List<UserAnswer>> getUserAnswersByHistoryId(int historyId) async {
    final results = await _userAnswerController.getUserAnswersByHistoryId(historyId);
    return results.map((entity) => UserAnswerMapper.toDomain(entity)).toList();
  }

  @override
  Future<void> insertUserAnswer(UserAnswer userAnswer) async {
    final entity = UserAnswerMapper.toEntity(userAnswer);
    return await _userAnswerController.insertUserAnswer(entity);
  }

}

