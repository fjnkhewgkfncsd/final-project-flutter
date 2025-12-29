import '../mapper/emergencyAction.mapper.dart';
import '../../domain/model/emergencyAction.model.dart';
import '../service/controller/emergencyAction.controller.dart';
import '../../domain/interface/Irepository.interface.dart';

class EmergencyActionRepoImpl implements IEmergencyActionRepo {
  final EmergencyActionController _emergencyActionController = EmergencyActionController();

  @override
  Future<EmergencyAction?> getById(int id) async {
    final result = await _emergencyActionController.getEmergencyActionById(id);
    return result == null ? null : EmergencyActionMapper.toDomain(result);
  }
}