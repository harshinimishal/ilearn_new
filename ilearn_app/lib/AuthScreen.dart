import 'package:flutter/material.dart';
import 'SignUpLoginPage.dart';
class AuthScreen extends StatelessWidget {
  final Function() onLogout;
  const AuthScreen({super.key, required this.onLogout});

  void changePassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: const TextField(obscureText: true, decoration: InputDecoration(labelText: 'New Password')),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            TextButton(onPressed: () {/* Update password logic */ Navigator.pop(context);}, child: const Text('Save')),
          ],
        );
      },
    );
  }

  void logout(BuildContext context) {
    onLogout();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUpLoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(leading: const Icon(Icons.lock), title: const Text('Change Password'), onTap: () => changePassword(context)),
            ListTile(leading: const Icon(Icons.swap_horiz), title: const Text('Switch Account'), onTap: () {}),
            ListTile(leading: const Icon(Icons.logout), title: const Text('Logout'), onTap: () => logout(context)),
          ],
        ),
      ),
    );
  }
}
