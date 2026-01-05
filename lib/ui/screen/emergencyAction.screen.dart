import 'package:flutter/material.dart';
import '../../domain/model/emergencyAction.model.dart';
import '../widget/customizeButton.widget.dart';
import '../screen/home_Screen.dart';
import '../../domain/service/favorite.service.dart';
import '../../data/repo/favorite.repo.dart';
import '../../domain/model/favorite.model.dart';
import '../../data/repo/answer.repo.dart';
import '../../domain/service/answer.service.dart';
import '../../data/repo/userAnswer.repo.dart';
import '../../domain/service/userAnswer.service.dart';
import '../../domain/model/answer.model.dart';
import '../../domain/model/userAnswer.model.dart';


class EmergencyActionScreen extends StatefulWidget {
  final int historyId;
  final bool isFromQuiz;
  EmergencyAction? emergency;
  EmergencyActionScreen({super.key, required this.historyId,this.emergency, this.isFromQuiz = false});

  @override
  State<EmergencyActionScreen> createState() => _EmergencyActionScreenState();
}

class _EmergencyActionScreenState extends State<EmergencyActionScreen> {
  final FavoriteService _favoriteService = FavoriteService(FavoriteRepoImpl());
  final AnswerService _answerService = AnswerService(AnswerRepoImpl());
  final UserAnswerService _userAnswerService = UserAnswerService(UserAnswerRepoImpl());

  bool isFav = false;
  List<Answer> answers = [];
  List<UserAnswer> userAnswers = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if(widget.emergency == null) {
      _loadAnswers().then((_) {
        setState(() {
          widget.emergency = getEmergencyAction();
        });
      });
    }
  }

  Future<void> _loadAnswers() async {
    setState((){
      isLoading = true;
    });
    answers = await _answerService.getAnswersByHistoryId(widget.historyId);
    userAnswers = await _userAnswerService.getAllUserAnswersByHistoryId(widget.historyId);
    setState((){
      isLoading = false;
    });
  }

  EmergencyAction getEmergencyAction(){
    for(var userAnswer in userAnswers){
      for(var answer in answers){
        if(answer.answerId == userAnswer.answerId){
          if(answer.emergencyAction != null){
            return answer.emergencyAction!;
          }
        }
      }
    }
    return EmergencyAction(
      id: 0,
      actionTitle: 'No Action Found',
      instruction: 'No Instruction Available',
      level: 'Unknown',
    );
  }

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
    return isFav ? Icon(Icons.favorite, color: Colors.red,size: 25,) :  Icon(Icons.favorite_border,size: 25,);
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
    if(isLoading){
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
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
                    widget.emergency!.actionTitle,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Container(
                    width:200,
                    height:70,
                    decoration: BoxDecoration(
                      color: getLevelColor(widget.emergency!.level),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Level: ${widget.emergency!.level}',
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
                    widget.emergency!.instruction,
                    style: const TextStyle(fontSize: 19),
                  ),
                ),
                if(widget.isFromQuiz) SizedBox(height: 72),
                if(widget.isFromQuiz) CustomizeButton(title:'add to Favorites', onPressed: toggleFavorite, color: Colors.greenAccent, icon: getIconFav(),),
                SizedBox(height: 16),
                CustomizeButton(title:'Back to Home', onPressed:() => navigateToHome(context), color: Colors.green, icon: Icon(Icons.home,size: 25,),), 
              ],
            ),
          )
        ]
      )
    );
  }
}