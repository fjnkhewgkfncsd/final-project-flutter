import 'package:flutter/material.dart';
import 'package:project/domain/model/emergencyView.model.dart';
import '../tab/favorite_Tab.dart';
// import '../tab/history_Tab.dart';
import '../tab/home_Tab.dart';
import '../../ui/screen/search_Emergency.dart';
import '../../animations/search_transition_Animation.dart';
import '../../domain/model/emergency.model.dart';
import '../../domain/service/emergency.service.dart';
import '../../domain/service/history.service.dart';
import '../../domain/service/favorite.service.dart';
import '../../domain/model/history.model.dart';
import '../screen/start_Screen.dart';
import '../../domain/model/historyView.model.dart';
import '../../domain/model/favorite.model.dart';
import '../../data/repo/emergency.repo.dart';
import '../../data/repo/history.repo.dart';
import '../../data/repo/favorite.repo.dart';
import '../../domain/service/category.service.dart';
import '../../data/repo/category.repo.dart';
import '../../domain/model/category.model.dart';
import '../widget/appButtonNavigation.widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  int _currentIndex = 0;
  late final EmergencyService _emergencyService ;
  late final HistoryService _historyService ;
  late final FavoriteService _favoriteService ;
  late final CategoryService _categoryService ;

  late List<HistoryViewModel> _histories;
  late List<Favorite> _favorites;
  late List<EmergencyViewModel> _emergencies;
  late List<Category> _categories;

  @override
  void initState() {
    super.initState();
    _emergencyService = EmergencyService(EmergencyRepoImpl());
    _historyService = HistoryService(HistoryRepoImpl());
    _favoriteService = FavoriteService(FavoriteRepoImpl());
    _categoryService = CategoryService(CategoryRepoImpl());
    _loadData();
    
  }

  Future<void> _loadData() async {
    _emergencies = await _emergencyService.getAllEmergencyViews();
    _histories = await _historyService.getAllHistoryViews();
    _favorites = await _favoriteService.getFavorites();
    _categories = await _categoryService.getAllCategories();
    setState((){
      isLoading = false;
    });
  }

  void _navigateToSearch() {
    Navigator.of(context).push(
      SearchTransition.createRoute(
        SearchEmergencyScreen(emergencies: _emergencies),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return StartScreen();
    }
    final List<Widget> tabs = [
    HomeTab(categories:_categories, emergencies:_emergencies),
    FavoriteTab(),
    FavoriteTab(tabName: 'history',),
  ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        elevation: 2,
        title: _currentIndex == 0 
            ? GestureDetector(
                onTap: _navigateToSearch,
                child: Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Search emergency...',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Text(
                _currentIndex == 1 ? 'Favorites' : 'History',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: tabs[_currentIndex],
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}