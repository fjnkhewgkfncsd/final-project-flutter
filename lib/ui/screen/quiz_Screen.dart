import 'package:flutter/material.dart';
import '../../ui/tab/favorite_Tab.dart'; 

class QuizScreen extends StatefulWidget {
  final String emergencyTitle;
  final IconData emergencyIcon;
  final String emergencyCategory;

  const QuizScreen({
    super.key,
    required this.emergencyTitle,
    required this.emergencyIcon,
    required this.emergencyCategory,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  List<Map<String, dynamic>>? _answers;
  bool _showResults = false;
  String _treatmentType = '';
  bool _isFavorite = false;

  // Define your quiz questions and answers based on emergency type
  List<Map<String, dynamic>> _getQuizData() {
    if (widget.emergencyTitle == 'Burns') {
      return [
        {
          'question': 'Is the burn severe?',
          'options': ['Yes', 'No'],
        },
        {
          'question': 'Is the burn caused by fire, hot liquid, or electricity?',
          'options': ['Fire', 'Hot Liquid', 'Electricity'],
        },
        {
          'question': 'Is the burn area larger than 3 inches?',
          'options': ['Yes', 'No'],
        },
        {
          'question': 'Is the burn on face, hands, feet, or genitals?',
          'options': ['Yes', 'No'],
        },
      ];
    }
    // Add more emergency types as needed
    return [];
  }

  void _selectAnswer(String answer) {
    setState(() {
      if (_answers == null) {
        _answers = [];
      }
      
      _answers!.add({
        'question': _getQuizData()[_currentQuestionIndex]['question'],
        'answer': answer,
      });

      if (_currentQuestionIndex < _getQuizData().length - 1) {
        _currentQuestionIndex++;
      } else {
        // Quiz completed - determine treatment and show results
        _determineTreatment();
        _showResults = true;
      }
    });
  }

  void _determineTreatment() {
    // Logic to determine treatment based on answers
    final answers = _answers ?? [];
    
    // Check for severe burns
    final isSevere = answers.any((answer) => 
        answer['question'] == 'Is the burn severe?' && answer['answer'] == 'Yes');
    
    // Check for sensitive areas
    final isSensitiveArea = answers.any((answer) => 
        answer['question'] == 'Is the burn on face, hands, feet, or genitals?' && 
        answer['answer'] == 'Yes');
    
    // Check for large burn area
    final isLargeArea = answers.any((answer) => 
        answer['question'] == 'Is the burn area larger than 3 inches?' && 
        answer['answer'] == 'Yes');
    
    // Check for electricity burn
    final isElectricBurn = answers.any((answer) => 
        answer['question'] == 'Is the burn caused by fire, hot liquid, or electricity?' && 
        answer['answer'] == 'Electricity');
    
    if (isSevere || isSensitiveArea || isLargeArea || isElectricBurn) {
      _treatmentType = 'severe';
    } else {
      _treatmentType = 'first_degree';
    }
  }

  String _getTreatmentTitle() {
    return _treatmentType == 'severe' 
        ? 'Severe Burn' 
        : 'First-Degree Burn';
  }

  List<String> _getTreatmentSteps() {
    if (_treatmentType == 'severe') {
      return [
        'Call emergency services immediately (911)',
        'Do not remove clothing stuck to the burn',
        'Elevate the burned area if possible',
        'Cover loosely with a sterile, non-stick bandage',
        'Do not apply ice, ointments, or butter to the burn',
        'Monitor for signs of shock',
      ];
    } else {
      return [
        'Cool the burn: Hold under cool (not cold) running water for 10-15 minutes',
        'Remove tight items: Gently remove jewelry or tight clothing near the burn',
        'Cover the burn: Use a sterile gauze bandage or clean cloth',
        'Protect the area: Avoid pressure or friction on the burn',
        'Take pain relievers: Use over-the-counter pain medication if needed',
        'Monitor for infection: Watch for increased redness, swelling, or pus',
      ];
    }
  }

  void _goBack() {
    setState(() {
      if (_showResults) {
        _showResults = false;
      } else if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
        _answers?.removeLast();
      } else {
        Navigator.of(context).pop();
      }
    });
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    
    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite 
              ? 'Added to favorites' 
              : 'Removed from favorites',
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
    
    // In a real app, you would save this to a database or state manager
    _saveToFavorites();
  }

  void _saveToFavorites() {
    // Create favorite item data
    final favoriteItem = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': widget.emergencyTitle,
      'icon': widget.emergencyIcon,
      'category': widget.emergencyCategory,
      'treatmentType': _treatmentType,
      'treatmentTitle': _getTreatmentTitle(),
      'addedAt': DateTime.now(),
    };
    
    // Save to shared preferences or database
    print('Saved to favorites: $favoriteItem');
    
    // You would typically use a state management solution like Provider, Bloc, or Riverpod
    // Example: context.read<FavoriteProvider>().addFavorite(favoriteItem);
  }

  void _navigateToFavorites() {
    // Navigate to the HomeScreen with favorites tab selected
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          body: const FavoriteTab(), // Show favorites tab
          bottomNavigationBar: _buildBottomNavigationBar(1), // Select favorites tab
        ),
      ),
      (route) => false, // Remove all previous routes
    );
  }

  Widget _buildBottomNavigationBar(int selectedIndex) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        // Handle navigation to other tabs
        if (index == 0) {
          // Navigate to home
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else if (index == 1) {
          // Already on favorites
          // Do nothing or refresh
        } else if (index == 2) {
          // Navigate to history
          // You would implement history navigation here
        }
      },
      backgroundColor: Colors.white,
      elevation: 8,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          activeIcon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history_outlined),
          activeIcon: Icon(Icons.history),
          label: 'History',
        ),
      ],
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey[600],
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_showResults) {
      return _buildResultsScreen();
    }

    final quizData = _getQuizData();
    final currentQuestion = quizData[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _goBack,
        ),
        title: Text(
          widget.emergencyTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / quizData.length,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              minHeight: 4,
            ),
            
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question ${_currentQuestionIndex + 1} of ${quizData.length}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Text(
                      currentQuestion['question'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    Expanded(
                      child: ListView.builder(
                        itemCount: currentQuestion['options'].length,
                        itemBuilder: (context, index) {
                          final option = currentQuestion['options'][index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: InkWell(
                                onTap: () => _selectAnswer(option),
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          option,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: Colors.grey[400],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Bottom navigation overlay
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.home_outlined, color: Colors.red),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
            const SizedBox(width: 20),
            IconButton(
              icon: const Icon(Icons.favorite_outline, color: Colors.red),
              onPressed: _navigateToFavorites,
            ),
            const SizedBox(width: 20),
            IconButton(
              icon: const Icon(Icons.history_outlined, color: Colors.red),
              onPressed: () {
                // Navigate to history
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsScreen() {
    final treatmentSteps = _getTreatmentSteps();
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _goBack,
        ),
        title: Text(
          widget.emergencyTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Icon(
                        widget.emergencyIcon,
                        size: 60,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '# ${widget.emergencyTitle.toUpperCase()}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _getTreatmentTitle().toUpperCase(),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.emergencyCategory,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              const Text(
                'Step by Step Guide',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              
              const SizedBox(height: 10),
              
              const Divider(color: Colors.grey, height: 1),
              
              const SizedBox(height: 20),
              
              Column(
                children: treatmentSteps.asMap().entries.map((entry) {
                  final index = entry.key + 1;
                  final step = entry.value;
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              '$index',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            step,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 40),
              
              const Divider(color: Colors.grey, height: 1),
              
              const SizedBox(height: 20),
              
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _toggleFavorite();
                    // After adding to favorite, navigate to favorites tab
                    _navigateToFavorites();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 22,
                  ),
                  label: Text(
                    _isFavorite ? 'Added to Favorite' : 'Add to Favorite',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      // Bottom navigation overlay
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.home_outlined, color: Colors.red),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
            const SizedBox(width: 20),
            IconButton(
              icon: const Icon(Icons.favorite_outline, color: Colors.red),
              onPressed: _navigateToFavorites,
            ),
            const SizedBox(width: 20),
            IconButton(
              icon: const Icon(Icons.history_outlined, color: Colors.red),
              onPressed: () {
                // Navigate to history
              },
            ),
          ],
        ),
      ),
    );
  }
}