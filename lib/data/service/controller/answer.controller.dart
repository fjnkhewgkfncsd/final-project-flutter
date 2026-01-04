import '../db/database.service.dart';
import '../../entity/answer.entity.dart';

class AnswerController {
  final DataBaseService _databaseService = DataBaseService();

  Future<List<AnswerEntity>> getAnswersByQuestionId(int questionId) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'answer',
      where: 'questionId = ?',
      whereArgs: [questionId],
    );
    return maps.map((map) => AnswerEntity.fromMap(map)).toList();
  }

  Future<AnswerEntity?> getAnswerById(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'answer',
      where: 'answerId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return AnswerEntity.fromMap(maps.first);
    }
    return null;
  }

  Future<List<AnswerEntity>> getAnswersByHistoryId(int historyId) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT a.*, e.emergencyActionId, e.actionTitle, e.instruction, e.LevelOfDanger
      from history h
      JOIN question q on h.quizId = q.quizId
      JOIN answer a on q.questionId = a.questionId
      JOIN emergencyAction e on a.emergencyActionId = e.emergencyActionId
      WHERE h.historyId = ?
    ''', [historyId]);
    if (maps.isNotEmpty) {
      return maps.map((map) => AnswerEntity.fromMap(map)).toList();
    }
    return [];
  }
}