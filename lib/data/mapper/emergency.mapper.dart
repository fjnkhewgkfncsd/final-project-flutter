import 'entity/emergency.entity.dart';
import '../../domain/model/emergency.model.dart';

class EmergencyMapper{
  static Emergency toDomain(EmergencyEntity entity){
    return Emergency(
      id: entity.id,
      name: entity.name,
      image: entity.image,
    );
  }

  static EmergencyEntity toEntity(Emergency domain){
    return EmergencyEntity(
      id: domain.id,
      name: domain.name,
      image: domain.image,
    );
  }
}