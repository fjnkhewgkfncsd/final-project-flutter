import 'package:project/data/entity/historyView.entity.dart';
import '../../entity/history.entity.dart';
import '../db/database.service.dart';

class HistoryController{
  final DataBaseService _databaseService = DataBaseService();

  Future<HistoryEntity?> getHistoryById(int id) async {
    final db = await _databaseService.database;
    final result = await db.query(
      'history',
      where: 'historyId = ?',
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
  
  Future<List<HistoryViewEntity>> getAllHistoryViews() async {
    final db = await _databaseService.database;
    final result = await db.rawQuery('''
      SELECT h.historyId as id, h.quizId, h.timestamp, em.emergencyIcon, em.emergencyName , c.categoryName
      FROM history h
      JOIN quiz q ON h.quizId = q.quizId
      JOIN emergency em ON q.emergencyId = em.emergencyId
      JOIN category c ON em.categoryId = c.categoryId
      ORDER BY h.timestamp DESC
    ''');
    return result.map((map) => HistoryViewEntity.fromMap(map)).toList();
  }
  
  Future<int> insertHistory(int quizId) async {
    final db = await _databaseService.database;
    return await db.insert('history', {
      'quizId': quizId,
    });
  }

  Future<int> deleteHistory(int id) async {
    final db = await _databaseService.database;
    return await db.delete(
      'history',
      where: 'historyId = ?',
      whereArgs: [id],
    );
  }
}