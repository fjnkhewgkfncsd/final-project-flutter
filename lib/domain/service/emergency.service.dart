import '../interface/Irepository.interface.dart';
import '../model/emergency.model.dart';

class EmergencyService {
  final IEmergencyRepo _emergencyRepo;

  EmergencyService(this._emergencyRepo);

  Future<List<Emergency>> getAllEmergencies() async {
    return await _emergencyRepo.getAllEmergencies();
  }

  Future<Emergency?> getEmergencyById(int id) async {
    return await _emergencyRepo.getById(id);
  }
}