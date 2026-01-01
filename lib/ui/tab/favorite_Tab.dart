import 'package:flutter/material.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  // This would typically come from a state manager
  List<Map<String, dynamic>> favorites = [
    {
      'title': 'Burns',
      'icon': Icons.fireplace,
      'category': 'Injuries',
      'treatmentType': 'first_degree',
      'treatmentTitle': 'First-Degree Burn',
      'addedAt': DateTime.now().subtract(const Duration(days: 1)),
    },
    // Add more favorites as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: favorites.isEmpty
          ? _buildEmptyState()
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                  child: Text(
                    'My Favorites',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    '${favorites.length} saved treatments',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
                const SizedBox(height: 20),
                ...favorites.map((favorite) => _buildFavoriteCard(favorite)),
              ],
            ),
    );
  }

  Widget _buildFavoriteCard(Map<String, dynamic> favorite) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            favorite['icon'] as IconData,
            color: Colors.red,
            size: 24,
          ),
        ),
        title: Text(
          favorite['title'] as String,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              favorite['treatmentTitle'] as String,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            Text(
              favorite['category'] as String,
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.favorite, color: Colors.red),
          onPressed: () {
            // Remove from favorites
            setState(() {
              favorites.remove(favorite);
            });
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: Colors.grey.withOpacity(0.4),
          ),
          const SizedBox(height: 20),
          const Text(
            'No favorites yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Add treatments to favorites to see them here',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // Navigate back to home
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Browse Emergencies',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
