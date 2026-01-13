import 'package:flutter/material.dart';
import '../../domain/model/history.model.dart';
import '../../domain/model/favorite.model.dart';
import '../../domain/service/history.service.dart';
import '../../domain/service/favorite.service.dart';
import '../../data/repo/history.repo.dart';
import '../../data/repo/favorite.repo.dart';
import '../screen/emergencyAction.screen.dart';
import '../screen/home_Screen.dart';

class FavoriteTab extends StatefulWidget {
  final String tabName;
  final bool isActive;

  const FavoriteTab({
    super.key,
    this.tabName = 'Favorites',
    required this.isActive,
  });

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  final HistoryService _historyService =
      HistoryService(HistoryRepoImpl());
  final FavoriteService _favoriteService =
      FavoriteService(FavoriteRepoImpl());

  List<History> histories = [];
  List<Favorite> favorites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.isActive) {
      _loadContent();
    }
  }

  @override
  void didUpdateWidget(covariant FavoriteTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _loadContent();
    }
  }

  Future<void> _loadContent() async {
    setState(() => isLoading = true);

    if (widget.tabName.toLowerCase() == 'history') {
      histories = await _historyService.getAllHistories();
      _syncHistoryFavorites();
    } else {
      favorites = await _favoriteService.getFavoriteViews();
    }

    setState(() => isLoading = false);
  }

  void _syncHistoryFavorites() {
    for(var history in histories) {
      if(history.favorite != null) {
        history.isFav = true;
      } else {
        history.isFav = false;
      }
    }
  }

  void _updateFavoriteStatus(History history, bool isFav) {
    for(var his in histories) {
      if(his.id == history.id) {
        his.isFav = !isFav;
        break;
      }
    }
  }

  Future<void> toggleFavoriteForHistory(History history) async {
    if (history.isFav) {
      await _favoriteService.deleteFavoriteByHistoryId(history.id);
    } else {
      await _favoriteService.addFavorite(history.id);
    }
    _updateFavoriteStatus(history, history.isFav);
    setState((){
    });
    //await _loadContent();
  }

  Future<void> onRemoveHistory(History history) async {
    await _historyService.deleteHistory(history.id);
    await _loadContent();
  }

  Future<void> onRemoveFavorite(Favorite favorite) async {
    for(var fav in favorites) {
      if(fav.id == favorite.id) {
        favorites.remove(fav);
        break;
      }
    }
    setState((){
    });
    await _favoriteService.deleteFavorite(favorite.id!);
  }

  Widget getTrailing(dynamic item) {
    if (widget.tabName.toLowerCase() == 'history') {
      return IconButton(
        icon: Icon(
          item.isFav ? Icons.favorite : Icons.favorite_border,
          color: item.isFav ? Colors.red : Colors.grey,
        ),
        onPressed: () => toggleFavoriteForHistory(item),
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.favorite, color: Colors.red),
        onPressed: () => onRemoveFavorite(item),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final content =
        widget.tabName.toLowerCase() == 'history'
            ? histories
            : favorites;

    if (content.isEmpty) {
      return _buildEmptyState();
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'My ${widget.tabName}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            widget.tabName.toLowerCase() == 'history'
                ? '${histories.length} Lookups'
                : '${favorites.length} saved treatments',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ),
        const SizedBox(height: 20),
        ...content.map((item) {
          if (item is History) {
            return _buildHistoryCard(item);
          }
          return _buildFavoriteCard(item as Favorite);
        }),
      ],
    );
  }

  Widget _buildHistoryCard(History history) {
    return Dismissible(
      key: Key('history_${history.id}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onRemoveHistory(history),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  EmergencyActionScreen(historyId: history.id),
            ),
          );
        },
        child: Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                history.emergency.icon,
                color: Colors.red,
              ),
            ),
            title: Text(history.emergency.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(history.emergency.category.categoryName),
                Text(
                  history.timestamp
                      .toLocal()
                      .toString()
                      .split(' ')[0],
                ),
              ],
            ),
            trailing: getTrailing(history),
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteCard(Favorite favorite) {
    return Dismissible(
      key: Key('favorite_${favorite.id}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onRemoveFavorite(favorite),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => EmergencyActionScreen(
                historyId: favorite.history.id,
              ),
            ),
          );
        },
        child: Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                favorite.history.emergency.icon,
                color: Colors.red,
              ),
            ),
            title: Text(favorite.history.emergency.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  favorite
                      .history.emergency.category.categoryName,
                ),
                Text(
                  favorite.history.timestamp
                      .toLocal()
                      .toString()
                      .split(' ')[0],
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
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => HomeScreen(),
                ),
                (_) => false,
              );
            },
            child: const Text('Browse Emergencies'),
          ),
        ],
      ),
    );
  }
}
