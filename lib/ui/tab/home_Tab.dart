import 'package:flutter/material.dart';
import '../../animations/fade_grid_Animation.dart';
import '../../domain/model/category.model.dart';
import '../../domain/model/emergencyView.model.dart';
// Import the QuizScreen
import '../../ui/screen/quiz_Screen.dart'; // You'll need to create this

class HomeTab extends StatefulWidget {
  final List<Category> categories;
  final List<EmergencyViewModel> emergencies;
  const HomeTab({super.key,required this.categories, required this.emergencies});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String _selectedFilter = 'ALL';
  
  List<String> get _filterOptions {
    List<String> options = ['ALL'];
    options.addAll(widget.categories.map((category) => category.categoryName));
    return options;
  }
  List<EmergencyViewModel> get _filteredEmergencies {
    if(_selectedFilter == 'ALL') {
      return widget.emergencies;
    } else {
      return widget.emergencies.where((emergency) => emergency.categoryId == widget.categories.firstWhere((category) => category.categoryName == _selectedFilter).categoryId).toList();
    }
  }
  
  void _onEmergencyTap(EmergencyViewModel emergency) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QuizScreen(
          emergency:emergency
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: Text(
            'Emergency Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Dropdown Filter
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                const Icon(Icons.filter_list, color: Colors.red, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedFilter,
                      icon: const Icon(Icons.arrow_drop_down, size: 20),
                      elevation: 8,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedFilter = newValue!;
                        });
                      },
                      items: _filterOptions.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: const TextStyle(fontSize: 14)),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          child: Text(
            '${_filteredEmergencies.length} emergencies found',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: FadeGridAnimation(
            selectedFilter: _selectedFilter,
            emergencies: _filteredEmergencies,
            onEmergencyTap: _onEmergencyTap,
            categories: widget.categories,
          ),
        ),
      ],
    );
  }
}