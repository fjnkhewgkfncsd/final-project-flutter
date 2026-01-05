import 'package:flutter/material.dart';
class EmergencyViewModel {
  final int id;
  final String name;
  final IconData icon;
  final int categoryId;
  final String categoryName;

  const EmergencyViewModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.categoryId,
    required this.categoryName,
  });
}