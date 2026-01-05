import 'package:flutter/material.dart';

class FavoriteViewModel{
  final int id;
  final int historyId;
  final IconData icon;
  final String title;
  final DateTime timestamp;
  final String category;

  const FavoriteViewModel({
    required this.id,
    required this.historyId,
    required this.icon,
    required this.title,
    required this.timestamp,
    required this.category,
  });

  factory FavoriteViewModel.fromMap(Map<String, dynamic> map) {
    return FavoriteViewModel(
      id: map['id'],
      historyId: map['historyId'],
      icon: map['emergencyIcon'],
      title: map['emergencyName'],
      timestamp: DateTime.parse(map['timestamp']),
      category: map['categoryName'],
    );
  }
}