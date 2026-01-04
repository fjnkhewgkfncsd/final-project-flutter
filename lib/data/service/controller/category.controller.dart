import '../../entity/category.entity.dart';
import '../db/database.service.dart';

class CategoryController {
  final DataBaseService _databaseService = DataBaseService();

  Future<List<CategoryEntity>> getAllCategories() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('category');
    return maps.map((map) => CategoryEntity.fromMap(map)).toList();
  }

  Future<CategoryEntity?> getCategoryById(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'category',
      where: 'categoryId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return CategoryEntity.fromMap(maps.first);
    }
    return null;
  }
}