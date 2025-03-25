// ignore: file_names
import 'package:flutter/material.dart';
import '/ProgressDashboard.dart';
import '../widgets/SubjectCard.dart';
import '../widgets/FeatureCard.dart';
import '../widgets/AdvantageCard.dart';
import '/ChatScreen.dart';
import '/ARScreen.dart';
import '/Textbooks.dart';
import '../widgets/BottomNavBar.dart';

class HomeScreen extends StatelessWidget {
  final String userName;

  const HomeScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              ProgressDashboard(userName: userName),
              const SizedBox(height: 30),
              _buildSectionTitle('Subjects'),
              _buildSubjects(),
              const SizedBox(height: 30),
              _buildSectionTitle('Explore'),
              _buildExploreFeatures(context),
              const SizedBox(height: 30),
              _buildSectionTitle('Why Choose Us?'),
              _buildAdvantages(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(userName: userName),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/images/ilearn_logo.png', height: 40),
        CircleAvatar(
          backgroundColor: Colors.blue.shade700,
          radius: 25,
          child: Text(
            userName[0].toUpperCase(),
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
    );
  }

  Widget _buildSubjects() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SubjectCard(title: 'Science', image: 'assets/images/chemistry.png', onTap: () {}),
          SubjectCard(title: 'Math', image: 'assets/images/math.png', onTap: () {}),
          SubjectCard(title: 'History', image: 'assets/images/history.png', onTap: () {}),
          SubjectCard(title: 'Geography', image: 'assets/images/geography.png', onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildExploreFeatures(BuildContext context) {
    return Column(
      children: [
        FeatureCard(icon: Icons.people_outline, title: 'AI Tutor', description: 'Personalized learning assistant.', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen()))),
        FeatureCard(icon: Icons.book, title: 'Textbooks', description: 'Access a library of textbooks.', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TextbooksScreen()))),
        FeatureCard(icon: Icons.language, title: 'Multilingual Learning', description: 'Learn in multiple languages.', onTap: () {}),
        FeatureCard(icon: Icons.vrpano, title: 'AR & VR Models', description: 'Experience 3D learning.', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ARScreen()))),
      ],
    );
  }

  Widget _buildAdvantages() {
    return Column(
      children: [
        AdvantageCard(title: 'Comprehensive Subjects', description: 'Covers all major subjects.', image: 'assets/images/all_subjects.png'),
        AdvantageCard(title: 'Easy to Remember', description: 'Enhance memory with flashcards.', image: 'assets/images/easy_remember.png'),
        AdvantageCard(title: 'Free for All', description: 'No hidden charges, free learning.', image: 'assets/images/free_service.png'),
        AdvantageCard(title: '24/7 Access', description: 'Study anytime, anywhere.', image: 'assets/images/access.png'),
      ],
    );
  }
}