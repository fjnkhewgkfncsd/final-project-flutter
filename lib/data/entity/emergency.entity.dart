import 'package:flutter/material.dart';
class EmergencyEntity {
  final int id;
  final String name;
  final IconData icon;
  final int categoryId;

  const EmergencyEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.categoryId,
  });

  factory EmergencyEntity.fromMap(Map<String, dynamic> map) {
    return EmergencyEntity(
      id: map['emergencyId'],
      name: map['emergencyName'],
      icon: toIconData(map['emergencyIcon']),
      categoryId: map['categoryId'],
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