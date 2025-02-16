import 'package:flutter/material.dart';
import 'quiz_service.dart';
import 'ResultScreen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Map<String, dynamic>> _mcqs = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  final List<Map<String, dynamic>> _incorrectAnswers = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    QuizService quizService = QuizService();
    List<Map<String, dynamic>> questions = await quizService.getMCQs();
    setState(() {
      _mcqs = questions;
      _loading = false;
    });
  }

  void _submitAnswer(String selectedOption) {
    var questionData = _mcqs[_currentQuestionIndex];
    String correctAnswer = questionData['answer']['option'];

    if (selectedOption == correctAnswer) {
      _score++;
    } else {
      _incorrectAnswers.add({
        'question': questionData['question'],
        'selected': selectedOption,
        'correct': correctAnswer,
        'explanation': questionData['answer']['text'],
      });
    }

    if (_currentQuestionIndex < _mcqs.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: _score,
            total: _mcqs.length,
            incorrectAnswers: _incorrectAnswers,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildHeader(),
                Expanded(child: _buildContent()),
              ],
            ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF097D66),
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            'Quiz',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return _currentQuestionIndex < _mcqs.length ? _buildQuestionUI() : Container();
  }

  Widget _buildQuestionUI() {
    var questionData = _mcqs[_currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 8, spreadRadius: 2)],
            ),
            child: Text(
              questionData['question'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF121F49)),
            ),
          ),
          const SizedBox(height: 24),
          ...questionData['options'].entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ElevatedButton(
                onPressed: () => _submitAnswer(entry.key),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 2,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: Text(entry.value, style: const TextStyle(fontSize: 16)),
              ),
            );
          }),
          const Spacer(),
          Text(
            "Question ${_currentQuestionIndex + 1} / ${_mcqs.length}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
