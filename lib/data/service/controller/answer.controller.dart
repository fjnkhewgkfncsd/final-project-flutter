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
}