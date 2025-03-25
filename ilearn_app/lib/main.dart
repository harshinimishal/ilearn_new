import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import '/providers/language_provider.dart';
import '/SplashScreen.dart';
import '/HomeScreen.dart';
import '/ChapterScreen.dart';
import '/QuizScreen.dart';
import 'widgets/FlashCardsScreen.dart';
import '/SignUpLoginPage.dart';
import '/MainPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iLEARN',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      locale: provider.locale,
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('hi', ''), // Hindi
        Locale('fr', ''), // French
      ],
      home: const SplashScreen(),
      routes: {
        '/main': (context) => const MainPage(),
        '/home': (context) => const HomeScreen(userName: 'defaultUserName'),
        '/chapters': (context) => const ChaptersScreen(),
        '/flashcards': (context) => const FlashcardsScreen(),
        '/quizscreen': (context) => const QuizScreen(),
        '/signup-login': (context) => SignUpLoginPage(),
      },
    );
  }
}
