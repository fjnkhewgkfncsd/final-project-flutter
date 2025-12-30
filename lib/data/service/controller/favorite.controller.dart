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
  
  Future<int> insertFavorite(FavoriteEntity favorite) async {
    final db = await _databaseService.database;
    return await db.insert('favorite', {
      'quizId': favorite.historyId,
    });
  }

  Future<int> deleteFavorite(int id) async {
    final db = await _databaseService.database;
    return await db.delete(
      'favorite',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}