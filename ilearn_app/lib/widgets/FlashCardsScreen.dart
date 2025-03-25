import 'package:flutter/material.dart';

class FlashcardsScreen extends StatefulWidget {
  const FlashcardsScreen({super.key});

  @override
  State<FlashcardsScreen> createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<FlashcardContent> _flashcards = [
    FlashcardContent(
      title: "The orbit of a planet moving around the Sun.",
      content: "Kepler's First Law : The orbit of a planet is an ellipse with the Sun at one of the foci.",
      image: "assets/orbit.png",
    ),
    FlashcardContent(
      title: "Circular motion and Centripetal force",
      content: "As long as we are holding the string, we are pulling the stone towards us i.e. towards the centre of the circle and are applying a force towards it. The force stops acting if we release the string. In this case, the stone will fly off along a straight line which is the tangent to the circle at the position of the stone when the string is released, because that is the direction of its velocity at that instant of time...",
    ),
    // Add more flashcards here
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF097D66),
      appBar: AppBar(
        backgroundColor: const Color(0xFF097D66),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Chapter 1. Gravitation',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _flashcards.length,
              itemBuilder: (context, index) {
                return _buildFlashcard(_flashcards[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashcard(FlashcardContent flashcard) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    flashcard.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF121F49),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (flashcard.image != null) ...[
                    const SizedBox(height: 16),
                    Image.asset(
                      flashcard.image!,
                      fit: BoxFit.contain,
                    ),
                  ],
                  const SizedBox(height: 16),
                  Text(
                    flashcard.content,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: _currentPage > 0
                      ? () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      : null,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: _currentPage < _flashcards.length - 1
                      ? () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FlashcardContent {
  final String title;
  final String content;
  final String? image;

  FlashcardContent({
    required this.title,
    required this.content,
    this.image,
  });
}