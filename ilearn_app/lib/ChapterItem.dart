import 'package:flutter/material.dart';

class ChapterItem extends StatefulWidget {
  final String chapterNumber;
  final String title;
  final VoidCallback onFlashcardsPressed;
  final VoidCallback onStartQuizPressed;

  const ChapterItem({
    super.key,
    required this.chapterNumber,
    required this.title,
    required this.onFlashcardsPressed,
    required this.onStartQuizPressed,
  });

  @override
  State<ChapterItem> createState() => _ChapterItemState();
}

class _ChapterItemState extends State<ChapterItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF121F49),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.chapterNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF121F49),
                  ),
                ),
                const Spacer(),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: const Color(0xFF121F49),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Column(
              children: [
                _buildOptionButton('FLASH CARDS', widget.onFlashcardsPressed),
                _buildOptionButton('Take a Test', widget.onStartQuizPressed),
                _buildOptionButton('CHAPTER SOLUTION', () {}),
                _buildOptionButton('NOTES', () {}),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildOptionButton(String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF097D66),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}