import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  final String userName;

  const ProfileScreen({super.key, required this.userName});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic> userData = {};
  bool isEditing = false;
  bool isProfileComplete = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    String uid = _auth.currentUser!.uid;
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
    setState(() {
      userData = userDoc.data() as Map<String, dynamic>;
      _checkProfileCompletion();
    });
  }

  void _updateUserData() async {
    String uid = _auth.currentUser!.uid;
    await _firestore.collection('users').doc(uid).update(userData);
    setState(() {
      isEditing = false;
      _checkProfileCompletion();
    });
  }

  void _checkProfileCompletion() {
    isProfileComplete = userData.containsKey('age') &&
        userData.containsKey('contact') &&
        userData.containsKey('schoolName') &&
        userData['age'].toString().isNotEmpty &&
        userData['contact'].toString().isNotEmpty &&
        userData['schoolName'].toString().isNotEmpty;
  }

  void _logout() async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (isEditing) {
                _updateUserData();
              }
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: userData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: isProfileComplete ? Colors.green : Colors.grey,
                          child: Icon(
                            isProfileComplete ? Icons.check_circle : Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(userData['name'] ?? "User", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        Text(userData['email'] ?? "", style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildField("Contact", 'contact'),
                  _buildField("Age", 'age'),
                  _buildField("School", 'schoolName'),
                  const SizedBox(height: 20),
                  isProfileComplete ? _buildDashboard() : _buildLockedDashboard(),
                  const SizedBox(height: 20),
                  _buildSettingsOptions(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _logout,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildField(String label, String key) {
    return ListTile(
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: isEditing
          ? TextFormField(
              initialValue: userData[key],
              onChanged: (value) => userData[key] = value,
            )
          : Text(userData[key] ?? "Not provided"),
    );
  }

  Widget _buildDashboard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Dashboard', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Quizzes Attempted: ${userData['quizzesAttempted'] ?? 0}'),
            Text('Marks Scored: ${userData['marksScored'] ?? 0}'),
            Text('Videos Watched: ${userData['videosWatched'] ?? 0}'),
          ],
        ),
      ),
    );
  }

  Widget _buildLockedDashboard() {
    return Card(
      elevation: 4,
      color: Colors.grey[300],
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Complete your profile to unlock the dashboard!',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsOptions() {
    return Column(
      children: [
        _buildSettingsTile(Icons.language, "Change Language", () {}),
        _buildSettingsTile(Icons.settings, "Account Settings", () {}),
        _buildSettingsTile(Icons.video_library, "Saved Videos", () {}),
        _buildSettingsTile(Icons.help_outline, "Help Center", () {}),
        _buildSettingsTile(Icons.info_outline, "About This App", () {}),
      ],
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}