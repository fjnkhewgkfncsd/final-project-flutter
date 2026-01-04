import 'package:flutter/material.dart';
import '../../domain/model/emergencyAction.model.dart';
import '../widget/customizeButton.widget.dart';
import '../screen/home_Screen.dart';
import '../../domain/service/favorite.service.dart';
import '../../data/repo/favorite.repo.dart';
import '../../domain/model/favorite.model.dart';
class EmergencyActionScreen extends StatefulWidget {
  final int historyId;
  final EmergencyAction emergency;
  const EmergencyActionScreen({super.key, required this.historyId, required this.emergency});

  @override
  State<EmergencyActionScreen> createState() => _EmergencyActionScreenState();
}

class _EmergencyActionScreenState extends State<EmergencyActionScreen> {
  final FavoriteService _favoriteService = FavoriteService(FavoriteRepoImpl());
  bool isFav = false;

  Color getLevelColor(String level) {
    switch (level.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Icon getIconFav(){
    return isFav ? Icon(Icons.favorite, color: Colors.red,) :  Icon(Icons.favorite_border);
  }

  void navigateToHome(BuildContext context) {
    if(isFav){
      onAddtoFavorites();
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (route) => false,
    );

  }

  void onAddtoFavorites(){
    _favoriteService.addFavorite(Favorite(historyId: widget.historyId));
  }

  void toggleFavorite(){
    setState((){
      isFav = !isFav;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Actions'),
      ),
      body: ListView(
        children : [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Center(
                  child: Text(
                    widget.emergency.actionTitle,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Container(
                    width:200,
                    height:70,
                    decoration: BoxDecoration(
                      color: getLevelColor(widget.emergency.level),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Level: ${widget.emergency.level}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Center(child: Text('Instructions:', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    widget.emergency.instruction,
                    style: const TextStyle(fontSize: 19),
                  ),
                ),
                SizedBox(height: 72),
                CustomizeButton(title:'add to Favorites', onPressed: toggleFavorite, color: Colors.blue, icon: getIconFav(),),
                SizedBox(height: 16),
                CustomizeButton(title:'Back to Home', onPressed:() => navigateToHome(context), color: Colors.blue),
              ],
            ),
          )
        ]
      )
    );
  }
}