import '../db/database.service.dart';
import '../../entity/favorite.entity.dart';
import '../../entity/favoriteView.entity.dart';

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
  
  Future<int> insertFavorite(FavoriteEntity favorite) async {
    final db = await _databaseService.database;
    return await db.insert('favorite', {
      'historyId': favorite.historyId,
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

  Future<List<FavoriteViewEntity>> getFavoriteViews()async {
    final db = await _databaseService.database;
    final result = await db.rawQuery('''
      SELECT f.favoriteId as id, h.historyId, e.emergencyIcon, e.emergencyName, h.timestamp, c.categoryName
      FROM favorite f
      JOIN history h ON f.historyId = h.historyId
      JOIN quiz q on h.quizId = q.quizId
      JOIN emergency e on q.emergencyId = e.emergencyId
      JOIN category c on e.categoryId = c.categoryId
      ORDER BY h.timestamp DESC
    ''');
    return result.map((map) => FavoriteViewEntity.fromMap(map)).toList();
  }
}