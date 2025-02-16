import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;
  final List<Map<String, dynamic>> incorrectAnswers;

  const ResultScreen({super.key, required this.score, required this.total, required this.incorrectAnswers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 13.0,
              animation: true,
              percent: score / total,
              center: Text(
                "$score/$total",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.green,
            ),
            const SizedBox(height: 20),

            Text(
              score >= 7 ? "🎉 Great Job! Keep it up!" : "📖 Keep practicing!",
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            if (incorrectAnswers.isNotEmpty) ...[
              const Text(
                "Incorrect Answers & Explanations",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: incorrectAnswers.length,
                  itemBuilder: (context, index) {
                    var item = incorrectAnswers[index];
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("❌ ${item['question']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text("Your Answer: ${item['selected']}", style: const TextStyle(color: Colors.red)),
                            Text("✅ Correct Answer: ${item['correct']}", style: const TextStyle(color: Colors.green)),
                            Text("📖 Explanation: ${item['explanation']}", style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF097D66),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text("Try Again", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
