import '../entity/emergencyView.entity.dart';
import '../../domain/model/emergencyView.model.dart';

class EmergencyViewMapper{
  static EmergencyViewModel toViewModel(EmergencyViewEntity entity){
    return EmergencyViewModel(
      id: entity.id,
      name: entity.name,
      icon: entity.icon,
      categoryId: entity.categoryId,
      categoryName: entity.categoryName,
    );
  }
}