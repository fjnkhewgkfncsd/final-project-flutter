import '../model/answer.model.dart';
import '../model/question.model.dart';
import '../model/emergencyAction.model.dart';
import '../model/emergency.model.dart';
import '../model/favorite.model.dart';
import '../model/history.model.dart';
import '../model/quiz.model.dart';
import '../model/userAnswer.model.dart';

abstract class Irepository<T, Id>{
  Future<T?> getById(Id id);
}

abstract class IHistoryRepo extends Irepository<History, int> {
  Future<List<History>> getAllHistories();
  Future<int> insertHistory(History history);
  Future<int> deleteHistory(int id);
}

abstract class IFavoriteRepo extends Irepository<Favorite, int> {
  Future<List<Favorite>> getAllFavorites();
  Future<int> insertFavorite(Favorite favorite);
  Future<int> deleteFavorite(int id);
}

abstract class IEmergencyRepo extends Irepository<Emergency, int> {
  Future<List<Emergency>> getAllEmergencies();
}

abstract class IEmergencyActionRepo extends Irepository<EmergencyAction, int> {
}

abstract class IQuizRepo extends Irepository<Quiz, int> {
  Future<Quiz?> getQuizByEmergencyId(int emergencyId);
  Future<Quiz?> getQuizWithQuestionsAndAnswers(int emergencyId);
}

abstract class IQuestionRepo extends Irepository<Question, int> {
  Future<List<Question>> getQuestionsByQuizId(int quizId);
  Future<List<Question>> getQuestionsWithAnswersByQuizId(int quizId);
}

abstract class IAnswerRepo extends Irepository<Answer, int> {
  Future<List<Answer>> getAnswersByQuestionId(int questionId);
}

abstract class IUserAnswerRepo extends Irepository<UserAnswer, int> {
  Future<List<UserAnswer>> getUserAnswersByHistoryId(int historyId);
  Future<void> insertUserAnswer(UserAnswer userAnswer);
}
