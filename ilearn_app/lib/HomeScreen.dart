import 'package:flutter/material.dart';
import '../widgets/ProgressCard.dart';
import '../widgets/SubjectCard.dart';
import '../widgets/FeatureCard.dart';
import '../widgets/AdvantageCard.dart';
import '/ChatScreen.dart';
import '/ARScreen.dart';
import '../widgets/BottomNavBar.dart'; // Ensure correct path

class HomeScreen extends StatelessWidget {
  final String userName;

  const HomeScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5EFF1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/ilearn_logo.png', height: 40),
                        const SizedBox(width: 10),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: const Color(0xFF097D66),
                      radius: 25,
                      child: Text(
                        userName[0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Welcome Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, $userName',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF097D66),
                      ),
                    ),
                    const Text(
                      "Let's start learning",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF097D66),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Progress Card
              const ProgressCard(learned: 46, total: 60),

              const SizedBox(height: 30),

              // Subjects Section
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Subjects',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF097D66),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SubjectCard(title: 'SCIENCE I', image: 'assets/images/chemistry.png', onTap: () {}),
                          SubjectCard(title: 'MATHEMATICS I', image: 'assets/images/math.png', onTap: () {}),
                          SubjectCard(title: 'SCIENCE II', image: 'assets/images/physics.png', onTap: () {}),
                          SubjectCard(title: 'MATHEMATICS II', image: 'assets/images/math2.png', onTap: () {}),
                          SubjectCard(title: 'HISTORY', image: 'assets/images/history.png', onTap: () {}),
                          SubjectCard(title: 'GEOGRAPHY', image: 'assets/images/geography.png', onTap: () {}),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Explore Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Explore',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF097D66),
                      ),
                    ),
                    const SizedBox(height: 15),
                    FeatureCard(
                      icon: Icons.people_outline,
                      title: 'AI TUTOR',
                      description: 'Get an AI-powered assistant to help you learn and grow smarter anytime, anywhere.',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen())),
                    ),
                    const SizedBox(height: 15),
                    FeatureCard(
                      icon: Icons.book,
                      title: 'TEXTBOOKS',
                      description: 'Access a vast library of textbooks at your fingertips.',
                      onTap: () {},
                    ),
                    const SizedBox(height: 15),
                    FeatureCard(
                      icon: Icons.language,
                      title: 'MULTILINGUAL',
                      description: 'Learn in multiple languages for better understanding.',
                      onTap: () {},
                    ),
                    const SizedBox(height: 15),
                    FeatureCard(
                      icon: Icons.vrpano,
                      title: 'AR & VR MODELS',
                      description: 'Experience interactive 3D learning models.',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ARScreen())),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Advantages Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Advantages',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF097D66),
                      ),
                    ),
                    const SizedBox(height: 15),
                    AdvantageCard(
                      title: 'ALL SUBJECTS',
                      description: 'Covers all major subjects with comprehensive content.',
                      image: 'assets/images/all_subjects.png',
                    ),
                    const SizedBox(height: 15),
                    AdvantageCard(
                      title: 'EASY TO REMEMBER',
                      description: 'Enhance memory with quizzes and flashcards.',
                      image: 'assets/images/easy_remember.png',
                    ),
                    const SizedBox(height: 15),
                    AdvantageCard(
                      title: 'FREE FOR ALL',
                      description: 'No hidden charges, free learning for everyone.',
                      image: 'assets/images/free_service.png',
                    ),
                    const SizedBox(height: 15),
                    AdvantageCard(
                      title: '24/7 ACCESS',
                      description: 'Study anytime, anywhere with full access.',
                      image: 'assets/images/access.png',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
