import 'package:flutter/material.dart';
import './category.model.dart';
import './quiz.model.dart';
class Emergency {
  final int id;
  final String name;
  final IconData icon;
  final Category category;
  final Quiz? quiz;

  const Emergency({
    required this.id,
    required this.name,
    required this.icon,
    required this.category,
    required this.quiz,
  });
}