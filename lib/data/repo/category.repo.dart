import '../mapper/category.mapper.dart';
import '../../domain/interface/Irepository.interface.dart';
import '../../domain/model/category.model.dart';
import '../service/controller/category.controller.dart';

class CategoryRepoImpl implements ICategoryRepo {
  final CategoryController _categoryController = CategoryController();

  @override
  Future<Category?> getById(int id) async {
    final categoryEntity = await _categoryController.getCategoryById(id);
    if (categoryEntity != null) {
      return CategoryMapper.toDomain(categoryEntity);
    }
    return null;
  }

  @override
  Future<List<Category>> getAllCategories() async {
    final categoryEntities = await _categoryController.getAllCategories();
    return categoryEntities
        .map((entity) => CategoryMapper.toDomain(entity))
        .toList();
  }

}