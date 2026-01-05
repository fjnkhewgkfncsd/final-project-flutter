class CategoryEntity{
  final int categoryId;
  final String categoryName;

  CategoryEntity({required this.categoryId, required this.categoryName});

  factory CategoryEntity.fromMap(Map<String, dynamic> map) {
    return CategoryEntity(
      categoryId: map['categoryId'],
      categoryName: map['categoryName'],
    );
  }
}