import 'package:flutter/material.dart';
class HistoryViewModel {
  final int id;
  final int quizId;
  final IconData icon;
  final String title;
  final DateTime timestamp;
  final String category;
  bool isFav;

  HistoryViewModel({
    required this.id,
    required this.quizId,
    required this.icon,
    required this.title,
    required this.timestamp,
    required this.category,
    this.isFav = false,
  });
}