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
    if(iconString == 'local_fire_department'){
      return Icons.local_fire_department;
    }else if(iconString == 'air'){
      return Icons.air;
    }else if(iconString == 'heart_broken'){
      return Icons.heart_broken;
    }else if(iconString == 'science'){
      return Icons.science;
    }else if(iconString == 'flash_on'){
      return Icons.flash_on;
    }else if(iconString == 'bloodtype'){
      return Icons.bloodtype;
    }else if(iconString == 'healing'){
      return Icons.healing;
    }else if(iconString == 'directions_boat'){
      return Icons.directions_boat;
    }
    return Icons.help;
  }
}