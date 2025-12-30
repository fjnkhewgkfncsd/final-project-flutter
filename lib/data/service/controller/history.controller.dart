import '../../entity/history.entity.dart';
import '../db/database.service.dart';
class HistoryController{
  final DataBaseService _databaseService = DataBaseService();

  Future<HistoryEntity?> getHistoryById(int id) async {
    final db = await _databaseService.database;
    final result = await db.query(
      'history',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return HistoryEntity.fromMap(result.first);
    }
    return null;
  }

  Future<List<HistoryEntity>> getAllHistory() async {
    final db = await _databaseService.database;
    final result = await db.query('history');
    return result.map((map) => HistoryEntity.fromMap(map)).toList();
  }
  
  Future<int> insertHistory(HistoryEntity history) async {
    final db = await _databaseService.database;
    return await db.insert('history', {
      'quizId': history.quizId,
    });
  }

  Future<int> deleteHistory(int id) async {
    final db = await _databaseService.database;
    return await db.delete(
      'history',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}