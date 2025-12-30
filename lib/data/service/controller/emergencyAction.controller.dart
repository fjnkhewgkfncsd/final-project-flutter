import '../db/database.service.dart';
import '../../mapper/entity/emergencyAction.entity.dart';

class EmergencyActionController {
  final DataBaseService _databaseService = DataBaseService();

  Future<EmergencyActionEntity?> getEmergencyActionById(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'emergencyAction',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return EmergencyActionEntity.fromMap(maps.first);
    }
    return null;
  }
}
