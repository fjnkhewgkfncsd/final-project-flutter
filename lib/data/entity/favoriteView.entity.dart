import './emergency.entity.dart';
import 'package:flutter/material.dart';
class FavoriteViewEntity{
  final int id;
  final int historyId;
  final IconData icon;
  final String title;
  final DateTime timestamp;
  final String category;

  const FavoriteViewEntity({
    required this.id,
    required this.historyId,
    required this.icon,
    required this.title,
    required this.timestamp,
    required this.category,
  });

  factory FavoriteViewEntity.fromMap(Map<String, dynamic> map) {
    return FavoriteViewEntity(
      id: map['id'],
      historyId: map['historyId'],
      icon: EmergencyEntity.toIconData(map['emergencyIcon']),
      title: map['emergencyName'],
      timestamp: DateTime.parse(map['timestamp']),
      category: map['categoryName'],
    );
  }
}