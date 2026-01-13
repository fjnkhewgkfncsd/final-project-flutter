import '../entity/emergency.entity.dart';
import '../../domain/model/emergency.model.dart';
import 'category.mapper.dart';
import './quiz.mapper.dart';
class EmergencyMapper{
  static Emergency toDomain(EmergencyEntity entity){
    return Emergency(
      id: entity.id,
      name: entity.name,
      icon: entity.icon,
      category: CategoryMapper.toDomainWithEmptyEmergency(entity.category),
      quiz: entity.quiz != null ? QuizMapper.toDomain(entity.quiz!) : null,
    );
  }
}