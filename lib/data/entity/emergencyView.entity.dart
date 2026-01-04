import 'package:flutter/material.dart';
class EmergencyViewEntity {
  final int id;
  final String name;
  final IconData icon;
  final int categoryId;
  final String categoryName;

  const EmergencyViewEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.categoryId,
    required this.categoryName,
  });

    factory EmergencyViewEntity.fromMap(Map<String, dynamic> map) {
    return EmergencyViewEntity(
      id: map['emergencyId'],
      name: map['emergencyName'],
      icon: toIconData(map['emergencyIcon']),
      categoryId: map['categoryId'],
      categoryName: map['categoryName'],
    );
  }
  static IconData toIconData(String iconString){
    if(iconString == 'fire_truck'){
      return Icons.fire_truck;
    }else{
      return Icons.local_hospital;
    }
  }
}