import 'package:flutter/material.dart';

class EmergencyData {
  static final List<Map<String, dynamic>> allEmergencies = [
    {'title': 'Heart Attack', 'icon': Icons.favorite, 'category': 'Heart & Medical'},
    {'title': 'Choking', 'icon': Icons.warning, 'category': 'Breathing Emergencies'},
    {'title': 'Bleeding', 'icon': Icons.bloodtype, 'category': 'Injuries'},
    {'title': 'Burns', 'icon': Icons.fireplace, 'category': 'Injuries'},
    {'title': 'Fracture', 'icon': Icons.broken_image, 'category': 'Injuries'},
    {'title': 'CPR', 'icon': Icons.emergency, 'category': 'Heart & Medical'},
    {'title': 'Asthma Attack', 'icon': Icons.air, 'category': 'Breathing Emergencies'},
    {'title': 'Anaphylaxis', 'icon': Icons.heart_broken_sharp, 'category': 'Heart & Medical'},
    {'title': 'Heat Stroke', 'icon': Icons.wb_sunny, 'category': 'Environmental'},
    {'title': 'Poisoning', 'icon': Icons.science, 'category': 'Poisoning'},
    {'title': 'Seizure', 'icon': Icons.accessibility, 'category': 'Other'},
    {'title': 'Stroke', 'icon': Icons.health_and_safety, 'category': 'Heart & Medical'},
    {'title': 'Sprain', 'icon': Icons.accessibility_new, 'category': 'Injuries'},
    {'title': 'Cuts', 'icon': Icons.cut, 'category': 'Injuries'},
    {'title': 'Drowning', 'icon': Icons.water_damage, 'category': 'Breathing Emergencies'},
    {'title': 'Hyperventilation', 'icon': Icons.airline_seat_recline_extra, 'category': 'Breathing Emergencies'},
    {'title': 'Diabetes', 'icon': Icons.monitor_heart, 'category': 'Heart & Medical'},
    {'title': 'Hypothermia', 'icon': Icons.ac_unit, 'category': 'Environmental'},
    {'title': 'Frostbite', 'icon': Icons.snowing, 'category': 'Environmental'},
    {'title': 'Sunburn', 'icon': Icons.wb_sunny_outlined, 'category': 'Environmental'},
    {'title': 'Drug Overdose', 'icon': Icons.medication, 'category': 'Poisoning'},
    {'title': 'Food Poisoning', 'icon': Icons.fastfood, 'category': 'Poisoning'},
    {'title': 'Infant CPR', 'icon': Icons.child_care, 'category': 'Pediatric'},
    {'title': 'Croup', 'icon': Icons.child_friendly, 'category': 'Pediatric'},
    {'title': 'Febrile Seizure', 'icon': Icons.thermostat, 'category': 'Pediatric'},
    {'title': 'Shock', 'icon': Icons.bolt, 'category': 'Other'},
    {'title': 'Fainting', 'icon': Icons.sentiment_dissatisfied, 'category': 'Other'},
  ];

  static final List<String> allFilters = [
    'ALL',
    'Injuries',
    'Breathing Emergencies',
    'Heart & Medical',
    'Environmental',
    'Poisoning',
    'Pediatric',
    'Other'
  ];

  // Helper method to get filtered emergencies
  static List<Map<String, dynamic>> getFilteredEmergencies(String filter) {
    if (filter == 'ALL') {
      return List.from(allEmergencies);
    }
    return allEmergencies
        .where((emergency) => emergency['category'] == filter)
        .toList();
  }

  // Get all unique categories
  static List<String> getCategories() {
    return allEmergencies
        .map((emergency) => emergency['category'] as String)
        .toSet()
        .toList();
  }

  // Search emergencies by title or category
  static List<Map<String, dynamic>> searchEmergencies(String query) {
    if (query.isEmpty) {
      return List.from(allEmergencies);
    }
    
    final lowercaseQuery = query.toLowerCase();
    return allEmergencies
        .where((emergency) {
          final title = emergency['title'] as String;
          final category = emergency['category'] as String;
          return title.toLowerCase().contains(lowercaseQuery) ||
                 category.toLowerCase().contains(lowercaseQuery);
        })
        .toList();
  }
}