import 'package:flutter/material.dart';
import '../../animations/fade_grid_Animation.dart';
import '../../data/mock_data/emergency_Data.dart';
// Import the QuizScreen
import '../../ui/screen/quiz_Screen.dart'; // You'll need to create this

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
    // Check if it's Burns to show quiz screen
    if (title == 'Burns') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => QuizScreen(
            emergencyTitle: title,
            emergencyIcon: icon,
            emergencyCategory: category,
          ),
        ),
      );
    } else {
      // For other emergencies, show the detail screen
      // You can navigate to a detail screen here
      print('Tapped: $title ($category)');
      // Example: Navigate to a detail screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(title),
              backgroundColor: Colors.red,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 80, color: Colors.red),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'First aid instructions would appear here...',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
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