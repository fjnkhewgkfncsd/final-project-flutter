import '../../domain/interface/Irepository.interface.dart';
import '../mapper/emergency.mapper.dart';
import '../service/controller/emergency.controller.dart';
import '../../domain/model/emergency.model.dart';

class EmergencyRepoImpl implements IEmergencyRepo {
  final EmergencyController _emergencyController = EmergencyController();

  @override
  Future<Emergency?> getById(int id) async {
    final result = await _emergencyController.getEmergencyById(id);
    return result == null ? null : EmergencyMapper.toDomain(result);
  }

  @override
  Future<List<Emergency>> getAllEmergencies() async {
    final results = await _emergencyController.getAllEmergency();
    return results.map((entity) => EmergencyMapper.toDomain(entity)).toList();
  }
}