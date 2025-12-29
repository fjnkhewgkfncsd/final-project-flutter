import '../../entity/userAnswer.entity.dart';
import '../db/database.service.dart';

class UserAnswerController {
  final DataBaseService _databaseService = DataBaseService();

  Future<void> insertUserAnswer(UserAnswerEntity userAnswer) async {
    final db = await _databaseService.database;
    await db.insert(
      'userAnswer',{
        'answerId': userAnswer.answerId,
        'quizId': userAnswer.quizId,
        'historyId': userAnswer.historyId,
      },
    );
  }

  Future<UserAnswerEntity?> getUserAnswerById(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'userAnswer',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return UserAnswerEntity.fromMap(maps.first);
    }
    return null;
  }

  Future<List<UserAnswerEntity>> getUserAnswersByHistoryId(int historyId) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'userAnswer',
      where: 'historyId = ?',
      whereArgs: [historyId],
    );
    return maps.map((map) => UserAnswerEntity.fromMap(map)).toList();
  }
}