import '../../entity/category.entity.dart';
import '../db/database.service.dart';
import '../../entity/emergency.entity.dart';
class CategoryController {
  final DataBaseService _databaseService = DataBaseService();

  Future<List<CategoryEntity>> getAllCategoriesWithEmergencies() async {
  final db = await _databaseService.database;
  final categoriesMap = await db.query('category');

  final categories =
      categoriesMap.map((map) => CategoryEntity.fromMap(map)).toList();

  List<CategoryEntity> result = [];

  for (final category in categories) {
    final fullEmergencyData = await db.rawQuery('''
    SELECT e.*, q.*, qs.*, ea.* FROM emergency e 
    LEFT JOIN quiz q ON e.emergencyId = q.emergencyId
    LEFT JOIN question qs ON q.quizId = qs.quizId
    LEFT JOIN answer a ON qs.questionId = a.questionId
    LEFT JOIN emergencyAction ea on a.emergencyActionId = ea.emergencyActionId
    WHERE e.categoryId = ?
    ''', [category.categoryId]);

    final Map<int, EmergencyEntity> emergencyMap = {};

    for(final map in fullEmergencyData) {
      final emergencyId = map['emergencyId'] as int;
      if (!emergencyMap.containsKey(emergencyId)) {
        emergencyMap[emergencyId] = EmergencyEntity.fromMap(map);
        emergencyMap[emergencyId]!.category = category;
      }
    }
    final emergencies = emergencyMap.values.toList();

    result.add(category.copyWith(emergencies: emergencies));
  }

  return result;
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