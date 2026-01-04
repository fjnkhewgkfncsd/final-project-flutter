import '../entity/category.entity.dart';
import '../../domain/model/category.model.dart';

class CategoryMapper{
  static Category toDomain(CategoryEntity entity){
    return Category(
      categoryId: entity.categoryId,
      categoryName: entity.categoryName,
    );
  }

  static CategoryEntity toEntity(Category domain){
    return CategoryEntity(
      categoryId: domain.categoryId,
      categoryName: domain.categoryName,
    );
  }
}