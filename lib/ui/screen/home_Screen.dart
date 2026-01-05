import 'package:flutter/material.dart';
import 'package:project/domain/model/emergencyView.model.dart';
import '../tab/favorite_Tab.dart';
// import '../tab/history_Tab.dart';
import '../tab/home_Tab.dart';
import '../../ui/screen/search_Emergency.dart';
import '../../animations/search_transition_Animation.dart';
import '../../domain/service/emergency.service.dart';
import '../../domain/service/history.service.dart';
import '../../domain/service/favorite.service.dart';
import '../screen/start_Screen.dart';
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

  late final EmergencyService _emergencyService;
  late final CategoryService _categoryService;

  late List<EmergencyViewModel> _emergencies;
  late List<Category> _categories;

  late final FavoriteTab favoriteTab;
  late final FavoriteTab historyTab;

  @override
  void initState() {
    super.initState();
    _emergencyService = EmergencyService(EmergencyRepoImpl());
    _categoryService = CategoryService(CategoryRepoImpl());
    favoriteTab = FavoriteTab(isActive: _currentIndex == 1,);
    historyTab = FavoriteTab(tabName: 'history', isActive: _currentIndex == 2); 
    _loadData();
  }

  Future<void> _loadData() async {
    _emergencies = await _emergencyService.getAllEmergencyViews();
    _categories = await _categoryService.getAllCategories();

    setState(() {
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
    if (isLoading) {
      return StartScreen();
    }

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
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Search emergency...',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
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
      body: IndexedStack(
      index: _currentIndex,
      children: [
        HomeTab(
          key: const PageStorageKey('home'),
          categories: _categories,
          emergencies: _emergencies,
        ),
        FavoriteTab(
          key: const PageStorageKey('favorite'),
          isActive: _currentIndex == 1,
        ),
        FavoriteTab(
          key: const PageStorageKey('history'),
          tabName: 'history',
          isActive: _currentIndex == 2,
        ),
      ],
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
