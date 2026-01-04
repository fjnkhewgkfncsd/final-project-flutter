import 'package:flutter/material.dart';
import './ui/screen/start_Screen.dart';
import './data/service/db/database.service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataBaseService().database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FirstAid Buddy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red, // Changed to red for FirstAid theme
        ),
        useMaterial3: true,
      ),
      home: const StartScreen(), // Changed to StartScreen
      debugShowCheckedModeBanner: false,
    );
  }
}
