import '../entity/category.entity.dart';
import '../../domain/model/category.model.dart';
import './emergency.mapper.dart';
class CategoryMapper{
  static Category toDomain(CategoryEntity entity){
    return Category(
      categoryId: entity.categoryId,
      categoryName: entity.categoryName,
      emergencies: entity.emergencies.map((e) => EmergencyMapper.toDomain(e)).toList(),
    );
  }

  static Category toDomainWithEmptyEmergency(CategoryEntity entity){
    return Category(
      categoryId: entity.categoryId,
      categoryName: entity.categoryName,
      emergencies: [],
    );
  }


  static CategoryEntity toEntity(Category domain){
    return CategoryEntity(
      categoryId: domain.categoryId,
      categoryName: domain.categoryName,
      emergencies: [],
    );
  }
}