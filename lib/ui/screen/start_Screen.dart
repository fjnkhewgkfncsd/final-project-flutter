import 'package:flutter/material.dart';
import '../../animations/startScreen_Animation.dart';
import 'home_Screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

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