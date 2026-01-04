import '../model/category.model.dart';
import '../interface/Irepository.interface.dart';

class CategoryService {
  final ICategoryRepo _categoryRepo;

  CategoryService(this._categoryRepo);

  Future<List<Category>> getAllCategories() async {
    return await _categoryRepo.getAllCategories();
  }

  Future<Category?> getCategoryById(int id) async {
    return await _categoryRepo.getById(id);
  }
}