import '../interface/Irepository.interface.dart';
import '../model/emergencyAction.model.dart';

class EmergencyActionService {
  final IEmergencyActionRepo _emergencyActionRepo;

  EmergencyActionService(this._emergencyActionRepo);

  Future<EmergencyAction?> getEmergencyActionById(int id) async {
    return await _emergencyActionRepo.getById(id);
  }
}