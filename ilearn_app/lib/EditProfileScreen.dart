import 'package:flutter/material.dart';
class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  final Function(Map<String, dynamic>) onProfileUpdated;

  const EditProfileScreen({
    super.key,
    required this.userData,
    required this.onProfileUpdated,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController standardController;
  late TextEditingController contactController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userData['name']);
    ageController = TextEditingController(text: widget.userData['age'].toString());
    standardController = TextEditingController(text: widget.userData['standard']);
    contactController = TextEditingController(text: widget.userData['contact']);
  }

  void saveProfile() {
    final updatedProfile = {
      'name': nameController.text,
      'age': int.parse(ageController.text),
      'standard': standardController.text,
      'contact': contactController.text,
    };
    widget.onProfileUpdated(updatedProfile);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Full Name')),
            TextField(controller: ageController, decoration: const InputDecoration(labelText: 'Age'), keyboardType: TextInputType.number),
            TextField(controller: standardController, decoration: const InputDecoration(labelText: 'Standard')),
            TextField(controller: contactController, decoration: const InputDecoration(labelText: 'Contact'), keyboardType: TextInputType.phone),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: saveProfile, child: const Text('Save Changes')),
          ],
        ),
      ),
    );
  }
}