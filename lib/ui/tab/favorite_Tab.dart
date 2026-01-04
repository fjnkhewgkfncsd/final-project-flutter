import 'package:flutter/material.dart';
import '../../domain/model/history.model.dart';
import '../../domain/model/favorite.model.dart';
import '../../domain/model/historyView.model.dart';

class FavoriteTab extends StatefulWidget {
  final String tabName;
  final List<Favorite>? favorites;
  final List<HistoryViewModel>? histories;
  const FavoriteTab({super.key,this.tabName = 'Favorites', this.favorites, this.histories});
  @override
  State<FavoriteTab> createState() => _FavoriteTabState();

  List<Object> get content {
    if(tabName == 'history'){
      return histories ?? [];
    }else{
      return favorites ?? [];
    }
  }
}
class _FavoriteTabState extends State<FavoriteTab> {
  late List<dynamic> content;

  @override
  void initState() {
    super.initState();
    content = List<dynamic>.from(widget.content);

  }

  void toggleHeartIconForHistory(History history){
    setState(() {
      history.isFav = !history.isFav;
      for(final favorite in widget.favorites!){
        if(favorite.historyId == history.id){
          widget.favorites?.remove(favorite);
          break;
        }
      }
      
    });
  }

  IconData getIconDataByHistoryId(int historyId){
    for(var history in widget.histories!){
      if(history.id == historyId){
        return history.icon;
      }
    }
    return Icons.help_outline;
  }

  HistoryViewModel? getHistoryById(int id){
    for(var history in widget.histories!){
      if(history.id == id){
        return history;
      }
    }
    return null;
  }

  String get itemQuantityText{
    if(widget.tabName == 'history'){
      int itemCount = widget.histories?.length ?? 0;
      return '$itemCount Lookups';
    }else{
      int itemCount = widget.favorites?.length ?? 0;
      return '$itemCount saved treatments';
    }
  }
  
  Object get objectType {
    if(widget.tabName == 'history'){
      return HistoryViewModel;
    }else{
      return Favorite;
    }
  }

  Widget getTrailingContent(dynamic content){
    if(widget.tabName == 'history'){
      if(content?.isFav){
        return IconButton(
          onPressed: () {
            toggleHeartIconForHistory(content);
          },
          icon: const Icon(Icons.favorite, color: Colors.red)
        );
      }else{
        return IconButton(
          onPressed: () {
            toggleHeartIconForHistory(content);
          },
          icon: const Icon(Icons.favorite_border, color: Colors.red)
        );
      }
    }else{
      return IconButton(
        icon: const Icon(Icons.favorite, color: Colors.red),
        onPressed: () {
          // Remove from favorites
          setState(() {
            this.content.remove(content);
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content.isEmpty
          ? _buildEmptyState()
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                  child: Text(
                    'My ${widget.tabName}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    itemQuantityText,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
                const SizedBox(height: 20),
                ...content.map((item) {
                  if (item is HistoryViewModel) {
                    return _buildHistoryCard(item);
                  } else {
                    return _buildFavoriteCard(item);
                  }
                })
              ],
            ),
    );
  }

  Widget _buildFavoriteCard(Favorite content) {
    final history = getHistoryById(content.historyId);
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
            getIconDataByHistoryId(content.historyId),
            color: Colors.red,
            size: 24,
          ),
        ),
        title: Text(
          history?.title ?? '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              history?.category ?? '',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            Text(
              history?.timestamp.timeZoneName ?? '',
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
        trailing: getTrailingContent(content)
      ),
    );
  }


  Widget _buildHistoryCard(HistoryViewModel content) {
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
            content.icon,
            color: Colors.red,
            size: 24,
          ),
        ),
        title: Text(
          content.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              content.category,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            Text(
              content.timestamp.timeZoneName,
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
        trailing: getTrailingContent(content)
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
