import './emergency.entity.dart';
class CategoryEntity{
  final int categoryId;
  final String categoryName;
  final List<EmergencyEntity> emergencies;

  CategoryEntity({required this.categoryId, required this.categoryName, required this.emergencies});

  factory CategoryEntity.fromMap(Map<String, dynamic> map) {
    return CategoryEntity(
      categoryId: map['categoryId'],
      categoryName: map['categoryName'],
      emergencies: [],
    );
  }

  CategoryEntity copyWith({
    List<EmergencyEntity>? emergencies,
  }) {
    return CategoryEntity(
      categoryId: categoryId,
      categoryName: categoryName,
      emergencies: emergencies ?? this.emergencies,
    );
  }
}