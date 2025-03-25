import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProgressDashboard extends StatefulWidget {
  final String userName;

  const ProgressDashboard({Key? key, required this.userName}) : super(key: key);

  @override
  _ProgressDashboardState createState() => _ProgressDashboardState();
}

class _ProgressDashboardState extends State<ProgressDashboard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  double progress = 0.0;
  int totalTasks = 0;
  int completedTasks = 0;

  @override
  void initState() {
    super.initState();
    _fetchProgress();
  }

  void _fetchProgress() async {
    String uid = _auth.currentUser!.uid;
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(uid).get();

    if (userDoc.exists) {
      var data = userDoc.data() as Map<String, dynamic>;
      int videosWatched = data['videosWatched'] ?? 0;
      int quizzesAttempted = data['quizzesAttempted'] ?? 0;
      int totalAvailable = data['totalTasks'] ?? 10; // Default total tasks

      int completed = videosWatched + quizzesAttempted;
      double percentage = totalAvailable > 0 ? completed / totalAvailable : 0.0;

      setState(() {
        totalTasks = totalAvailable;
        completedTasks = completed;
        progress = percentage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Progress',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 10),
          Text(
            '${(progress * 100).toInt()}% completed ($completedTasks of $totalTasks tasks)',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
