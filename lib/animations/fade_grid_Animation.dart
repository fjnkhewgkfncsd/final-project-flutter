import 'package:flutter/material.dart';
import '../domain/model/emergencyView.model.dart';
import '../domain/model/category.model.dart';

class FadeGridAnimation extends StatelessWidget {
  final List<Category> categories;
  final String selectedFilter;
  final List<EmergencyViewModel> emergencies;
  final Function(EmergencyViewModel) onEmergencyTap;

  

  const FadeGridAnimation({
    Key? key,
    required this.selectedFilter,
    required this.emergencies,
    required this.onEmergencyTap,
    required this.categories,
  }) : super(key: key);

  String getcategoryName(EmergencyViewModel emergency){
    return categories.firstWhere((category) => category.categoryId == emergency.categoryId).categoryName;
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: GridView.count(
        key: ValueKey<String>(selectedFilter), 
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.3,
        children: emergencies.map((emergency) {
          return _buildEmergencyCard(
            emergency
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmergencyCard(EmergencyViewModel emergency) {
    print(emergency.icon);
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => onEmergencyTap(emergency),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(emergency.icon, size: 28, color: Colors.red),
              ),
              const SizedBox(height: 8),
              Text(
                emergency.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                emergency.categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}