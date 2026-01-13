import '../db/database.service.dart';
import '../../entity/choice.entity.dart';

class AnswerController {
  final DataBaseService _databaseService = DataBaseService();

  Future<List<ChoiceEntity>> getAnswersByQuestionId(int questionId) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'answer',
      where: 'questionId = ?',
      whereArgs: [questionId],
    );
    return maps.map((map) => ChoiceEntity.fromMap(map)).toList();
  }

  Future<ChoiceEntity?> getAnswerById(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'answer',
      where: 'answerId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ChoiceEntity.fromMap(maps.first);
    }
    return null;
  }

  Future<List<ChoiceEntity>> getAnswersByHistoryId(int historyId) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT a.*, e.emergencyActionId, e.actionTitle, e.instruction, e.LevelOfDanger
      from history h
      JOIN userAnswer ua on h.historyId = ua.historyId
      JOIN answer a on ua.answerId = a.answerId
      JOIN emergencyAction e on a.emergencyActionId = e.emergencyActionId
      WHERE h.historyId = ?
    ''', [historyId]);
    if (maps.isNotEmpty) {
      return maps.map((map) => ChoiceEntity.fromMap(map)).toList();
    }
    return [];
  }
}