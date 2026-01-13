import 'package:flutter/material.dart';
import './category.entity.dart';
import './quiz.entity.dart';
class EmergencyEntity {
  final int id;
  final String name;
  final IconData icon;
  late final CategoryEntity category;
  final QuizEntity? quiz;

  EmergencyEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.quiz,
  });

  factory EmergencyEntity.fromMap(Map<String, dynamic> map) {
    return EmergencyEntity(
      id: map['emergencyId'],
      name: map['emergencyName'],
      icon: toIconData(map['emergencyIcon']),
      quiz: map['quizId'] != null ? QuizEntity.fromMap(map) : null,
    );
  }

  factory EmergencyEntity.fromMapWithCategory(Map<String, dynamic> map) {
    EmergencyEntity emergency;
    if(map['categoryId'] != null){
      emergency = EmergencyEntity(
        id: map['emergencyId'],
        name: map['emergencyName'],
        icon: toIconData(map['emergencyIcon']),
        quiz: map['quizId'] != null ? QuizEntity.fromMap(map) : null,
      );
      emergency.category = CategoryEntity.fromMap(map);
      return emergency;
    }
    return EmergencyEntity(
      id: map['emergencyId'],
      name: map['emergencyName'],
      icon: toIconData(map['emergencyIcon']),
      quiz: map['quizId'] != null ? QuizEntity.fromMap(map) : null,
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