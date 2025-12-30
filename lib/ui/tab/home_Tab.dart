import 'package:flutter/material.dart';
import '../../animations/fade_grid_Animation.dart';
import '../../data/mock_data/emergency_Data.dart'; 

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String _selectedFilter = 'ALL';
  List<Map<String, dynamic>> get _filteredEmergencies {
    return EmergencyData.getFilteredEmergencies(_selectedFilter);
  }
  void _onEmergencyTap(String title, IconData icon, String category) {
    print('Tapped: $title ($category)');
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
                      items: EmergencyData.allFilters.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: const TextStyle(fontSize: 14)),
                        );
                      }).toList(),
                    ),
                  ),
                ),
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
          ),
        ),
      ],
    );
  }
}