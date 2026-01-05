import 'package:flutter/material.dart';
class Emergency {
  final int id;
  final String name;
  final IconData icon;
  final int categoryId;

  const Emergency({
    required this.id,
    required this.name,
    required this.icon,
    required this.categoryId,
  });
}