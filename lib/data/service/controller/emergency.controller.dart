import '../../mapper/entity/emergency.entity.dart';
import '../db/database.service.dart';
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
}