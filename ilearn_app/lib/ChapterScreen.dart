import 'package:flutter/material.dart';
import 'ChapterItem.dart';

class ChaptersScreen extends StatelessWidget {
  const ChaptersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF097D66)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Chapters :',
          style: TextStyle(
            color: Color(0xFF097D66),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Chapters List
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                return ChapterItem(
                  chapterNumber: '01',
                  title: 'ABCDEF',
                  onFlashcardsPressed: () {
                    Navigator.pushNamed(context, '/flashcards');
                  },
                  onStartQuizPressed: () {
                    Navigator.pushNamed(context, '/quizscreen');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}