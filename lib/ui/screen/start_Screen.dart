import 'package:flutter/material.dart';
import '../../animations/startScreen_Animation.dart';
import 'home_Screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return StartScreenAnimation(
      onAnimationComplete: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png', 
                width: 400,
                height: 400,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),
              // App Title
             
            ],
          ),
        ),
      ),
    );
  }
}