import '../../entity/emergency.entity.dart';
import '../db/database.service.dart';
import '../../entity/emergencyView.entity.dart';
class EmergencyController {
  final DataBaseService _databaseService = DataBaseService();

  Future<List<EmergencyEntity>> getAllEmergency() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('emergency');
    return maps.map((map) => EmergencyEntity.fromMap(map)).toList();
  }
  
  Future<EmergencyEntity?> getEmergencyById(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'emergency',
      where: 'emergencyId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return EmergencyEntity.fromMap(maps.first);
    }
    return null;
  }
    Future<List<EmergencyEntity>> getEmergenciesByCategoryId(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT e.*
      FROM emergency e
      WHERE e.categoryId = ?
    ''', [id]);
    return maps.map((map) => EmergencyEntity.fromMap(map)).toList();
  }

  Future<List<EmergencyViewEntity>> getAllEmergencyViews() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT e.emergencyId, e.emergencyName, e.emergencyIcon, e.categoryId, c.categoryName
      FROM emergency e
      JOIN category c ON e.categoryId = c.categoryId
    ''');
    return maps.map((map) => EmergencyViewEntity.fromMap(map)).toList();
  }
}