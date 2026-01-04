import '../../domain/interface/Irepository.interface.dart';
import '../mapper/emergency.mapper.dart';
import '../service/controller/emergency.controller.dart';
import '../../domain/model/emergency.model.dart';
import '../../domain/model/emergencyView.model.dart';
import '../mapper/emergencyView.mapper.dart';

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

  @override
  Future<List<Emergency>> getEmergenciesByCategoryId(int id) async {
    final emergencyEntities = await _emergencyController.getEmergenciesByCategoryId(id);
    return emergencyEntities
        .map((entity) => EmergencyMapper.toDomain(entity))
        .toList();
  }

  @override
  Future<List<EmergencyViewModel>> getAllEmergencyViews() async {
    final results = await _emergencyController.getAllEmergencyViews();
    return results.map((entity) => EmergencyViewMapper.toViewModel(entity)).toList();
  }
}