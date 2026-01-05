import 'package:flutter/material.dart';
import '../../domain/model/historyView.model.dart';
import '../../domain/model/favorite.model.dart';
import '../../domain/service/history.service.dart';
import '../../domain/service/favorite.service.dart';
import '../../data/repo/history.repo.dart';
import '../../data/repo/favorite.repo.dart';
import '../../domain/model/favoriteView.model.dart';
import '../screen/emergencyAction.screen.dart';
import '../screen/home_Screen.dart';

class FavoriteTab extends StatefulWidget {
  final String tabName;
  final bool isActive;

  const FavoriteTab({super.key, this.tabName = 'Favorites',required this.isActive });

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  final HistoryService _historyService = HistoryService(HistoryRepoImpl());
  final FavoriteService _favoriteService = FavoriteService(FavoriteRepoImpl());

  List<HistoryViewModel> histories = [];
  List<FavoriteViewModel> favorites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  /// Load data from service
  Future<void> _loadContent() async {
    if (widget.tabName.toLowerCase() == 'history') {
      histories = await _historyService.getAllHistoryViews();
      favorites = await _favoriteService.getFavoriteViews();
      assignFavoritesToHistories();
    } else {
      favorites = await _favoriteService.getFavoriteViews();
    }
    setState(() => isLoading = false);
  }

  @override
  void didUpdateWidget(covariant FavoriteTab oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isActive && !oldWidget.isActive) {
      _loadContent();
    }
  }
  

  void assignFavoritesToHistories() {
    for(var history in histories){
      for(var favorite in favorites){
        if(history.id == favorite.historyId){
          history.isFav = true;
        }
      }
    }
  }


  FavoriteViewModel getFavoriteByHistoryId(int historyId) {
    favorites.firstWhere(
      (fav) => fav.historyId == historyId,
    );
    throw Exception('Favorite not found for historyId: $historyId');
  }
  /// Toggle favorite state for history item
  void toggleFavoriteForHistory(HistoryViewModel history) async {
    setState(() {
      history.isFav = !history.isFav;
    });
    if (history.isFav) {
      _favoriteService.addFavorite(Favorite(historyId: history.id));
    } else {
      _favoriteService.deleteFavoriteByHistoryId(history.id);
    }

    // Reload content to update UI
    await _loadContent();
  }

  void onRemoveHistory(HistoryViewModel history) async {
    await _historyService.deleteHistory(history.id);
  }

  void onRemoveFavorite(FavoriteViewModel favorite) async {
    await _favoriteService.deleteFavorite(favorite.id);
  }

  /// Build trailing heart icon
  Widget getTrailing(dynamic item) {
    if (widget.tabName.toLowerCase() == 'history') {
      return IconButton(
        icon: item.isFav
            ? const Icon(Icons.favorite, color: Colors.red)
            : const Icon(Icons.favorite_border, color: Colors.grey),
        onPressed: () => toggleFavoriteForHistory(item),
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.favorite, color: Colors.red),
        onPressed: () async {
          await _favoriteService.deleteFavorite(item.id);
          await _loadContent();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final content =
        widget.tabName.toLowerCase() == 'history' ? histories : favorites;

    if (content.isEmpty) {
      return _buildEmptyState();
    }

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: Text(
            'My ${widget.tabName}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            widget.tabName.toLowerCase() == 'history'
                ? '${histories.length} Lookups'
                : '${favorites.length} saved treatments',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ),
        const SizedBox(height: 20),
        ...content.map((item) {
          if (item is HistoryViewModel) {
            return _buildHistoryCard(item);
          } else {
            return _buildFavoriteCard(item as FavoriteViewModel);
          }
        }),
      ],
    );
  }

  Widget _buildHistoryCard(HistoryViewModel history) {
    return Dismissible(
      key: Key('history_${history.id}'),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onRemoveHistory(history);
        setState(() {
          histories.removeWhere((h) => h.id == history.id);
          });
      },
      child: GestureDetector(
        onTap: () {
          // Navigate to EmergencyActionScreen
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EmergencyActionScreen(
                historyId: history.id
              ),
            ),
          );
        },
        child: Card(
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
              child: Icon(history.icon, color: Colors.red, size: 24),
            ),
            title: Text(
              history.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  history.category,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                Text(
                  history.timestamp.toLocal().toString().split(' ')[0],
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
            trailing: getTrailing(history),
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteCard(FavoriteViewModel favorite) {

    return Dismissible(
      key: Key('favorite_${favorite.id}'),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onRemoveFavorite(favorite);
        setState(() {
          favorites.removeWhere((f) => f.id == favorite.id);
        });
      },
      child: GestureDetector(
        onTap: () {
          // Navigate to EmergencyActionScreen
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EmergencyActionScreen(
                historyId: favorite.historyId
              ),
            ),
          );
        },
        child: Card(
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
              child: Icon(favorite.icon,
                  color: Colors.red, size: 24),
            ),
            title: Text(
              favorite.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  favorite.category,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                Text(
                  favorite.timestamp.toLocal().toString().split(' ')[0],
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
            trailing: getTrailing(favorite),
          ),
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
          Text(
            'No ${widget.tabName} yet',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          if(widget.tabName == 'favorites') const Text(
            'Add treatments to favorites to see them here',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
                (route) => false,
              ); // Go back to Home
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
