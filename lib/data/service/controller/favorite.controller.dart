import '../db/database.service.dart';
import '../../entity/favorite.entity.dart';

class FavoriteService{
  final DataBaseService _databaseService = DataBaseService();

  Future<FavoriteEntity?> getFavoriteById(int id) async {
    final db = await _databaseService.database;
    final result = await db.query(
      'favorite',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return FavoriteEntity.fromMap(result.first);
    }
    return null;
  }

  Future<List<FavoriteEntity>> getAllFavorites() async {
    final db = await _databaseService.database;
    final result = await db.query('favorite');
    return result.map((map) => FavoriteEntity.fromMap(map)).toList();
  }
  
  Future<int> insertFavorite(int historyId) async {
    final db = await _databaseService.database;
    return await db.insert('favorite', {
      'historyId': historyId,
    });
  }

  Future<int> deleteFavorite(int id) async {
    final db = await _databaseService.database;
    return await db.delete(
      'favorite',
      where: 'favoriteId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteFavoriteByHistoryId(int historyId) async {
    final db = await _databaseService.database;
    return await db.delete(
      'favorite',
      where: 'historyId = ?',
      whereArgs: [historyId],
    );
  }

  Future<List<FavoriteEntity>> getFavoriteViews()async {
    final db = await _databaseService.database;
    final result = await db.rawQuery('''
      SELECT f.*, h.*, e.*, c.*, ua.*
      FROM favorite f
      JOIN history h ON f.historyId = h.historyId
      JOIN userAnswer ua on h.historyId = ua.historyId
      JOIN emergency e on h.emergencyId = e.emergencyId
      JOIN category c on e.categoryId = c.categoryId
      ORDER BY h.timestamp DESC
    ''');
    return result.map((map) => FavoriteEntity.fromMap(map)).toList();
  }
}