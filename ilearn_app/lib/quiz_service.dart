import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class QuizService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getMCQs() async {
    List<Map<String, dynamic>> mcqs = [];
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('MCQ_Collection')
          .doc('Chapter_1')
          .collection('MCQs')
          .get();

      List<QueryDocumentSnapshot> docs = snapshot.docs;
      docs.shuffle(Random()); // Shuffle questions randomly
      docs = docs.take(10).toList(); // Get only 10 MCQs

      for (var doc in docs) {
        mcqs.add(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("❌ Error fetching MCQs: $e");
    }

    return mcqs;
  }
}
