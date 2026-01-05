import 'package:flutter/material.dart';
import '../entity/emergency.entity.dart';
class HistoryViewEntity{
  final int id;
  final int quizId;
  final DateTime timestamp;
  final IconData icon;
  final String title;
  final String category;

  const HistoryViewEntity({
    required this.id,
    required this.quizId,
    required this.timestamp,
    required this.icon,
    required this.title,
    required this.category,
  });

  factory HistoryViewEntity.fromMap(Map<String, dynamic> map) {
    return HistoryViewEntity(
      id: map['id'],
      quizId: map['quizId'],
      timestamp: DateTime.parse(map['timestamp']),
      icon: EmergencyEntity.toIconData(map['emergencyIcon']),
      title: map['emergencyName'],
      category: map['categoryName'],
    );
  }
}