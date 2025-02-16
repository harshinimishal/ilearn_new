import 'package:flutter/material.dart';
import 'widgets/BottomToolbar.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF097D66),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Chapter 1. Gravitation Notes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Kepler's Three Laws of Planetary Motion:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF121F49),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildLawItem(
                    "1. Kepler's First Law (Law of Ellipses):",
                    "Planets move in elliptical orbits with the Sun at one of the foci.",
                  ),
                  const SizedBox(height: 16),
                  _buildLawItem(
                    "2. Kepler's Second Law (Law of Equal Areas):",
                    "A line joining a planet and the Sun sweeps out equal areas during equal intervals of time. This means a planet moves faster when it is closer to the Sun and slower when it is farther away.",
                  ),
                  const SizedBox(height: 16),
                  _buildLawItem(
                    "3. Kepler's Third Law (Law of Harmonies):",
                    "The square of the orbital period of a planet is directly proportional to the cube of the semi-major axis of its orbit. Mathematically, T2∝r3T2∝r3, where TTT is the orbital period and rrr is the semi-major axis of the orbit",
                  ),
                ],
              ),
            ),
          ),
          const BottomToolbar(),
        ],
      ),
    );
  }

  Widget _buildLawItem(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF121F49),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF121F49),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}