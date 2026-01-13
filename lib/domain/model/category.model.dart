import './emergency.model.dart';
class Category{
  final int categoryId;
  final String categoryName;
  final List<Emergency> emergencies ;

  const Category({required this.categoryId, required this.categoryName, required this.emergencies});

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      categoryId: map['categoryId'],
      categoryName: map['categoryName'],
      emergencies: map['emergencies'].toList()
    );
  }
}