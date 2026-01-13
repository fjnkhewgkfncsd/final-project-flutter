import 'package:flutter/material.dart';
import '../tab/favorite_Tab.dart';
// import '../tab/history_Tab.dart';
import '../tab/home_Tab.dart';
import '../../ui/screen/search_Emergency.dart';
import '../../animations/search_transition_Animation.dart';
import '../screen/start_Screen.dart';
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

  late final CategoryService _categoryService;

  late List<Category> _categories;


  @override
  void initState() {
    super.initState();
    _categoryService = CategoryService(CategoryRepoImpl());
    _loadData();
  }

  Future<void> _loadData() async {
    _categories = await _categoryService.getAllCategoriesWithEmergencies();
    if(!mounted){
      return;
    } 
    setState(() {
      isLoading = false;
    });
  }

  void _navigateToSearch() {
    Navigator.of(context).push(
      SearchTransition.createRoute(
        SearchEmergencyScreen(emergencies: _categories.expand((cat) => cat.emergencies).toList()),
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
          emergencies: _categories.expand((cat) => cat.emergencies).toList(),
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
