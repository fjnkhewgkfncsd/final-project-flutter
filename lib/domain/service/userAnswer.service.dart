import '../interface/Irepository.interface.dart';
import '../model/userAnswer.model.dart';

class UserAnswerService {
  final IUserAnswerRepo _userAnswerRepo;

  UserAnswerService(this._userAnswerRepo);

  Future<UserAnswer?> getUserAnswerById(int id) async {
    return await _userAnswerRepo.getById(id);
  }

  Future<List<UserAnswer>> getUserAnswersByQuizAttemptId(int historyId) async {
    return await _userAnswerRepo.getUserAnswersByHistoryId(historyId);
  }
  Future<int> insertUserAnswer(UserAnswer userAnswer) async {
    return await _userAnswerRepo.insertUserAnswer(userAnswer);
  }
}
