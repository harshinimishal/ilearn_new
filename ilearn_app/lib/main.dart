import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '/SplashScreen.dart';
import '/HomeScreen.dart';
import '/ChapterScreen.dart';
import '/QuizScreen.dart';
import 'widgets/FlashCardsScreen.dart';
import '/SignUpLoginPage.dart'; // Ensure this file exists in the 'screens' directory

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iLEARN',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(), // Now uses the separated SplashScreen
      routes: {
        '/home': (context) => const HomeScreen(userName: 'defaultUserName'),
        '/chapters': (context) => const ChaptersScreen(),
        '/flashcards': (context) => const FlashcardsScreen(),
        '/quizscreen': (context) => const QuizScreen(),
        '/signup-login': (context) => SignUpLoginPage(),
      },
    );
  }
}
