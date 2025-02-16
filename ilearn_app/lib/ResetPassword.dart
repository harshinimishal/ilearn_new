import 'package:flutter/material.dart';
import 'CongratulationsScreen.dart';
import '../widgets/custom_input_field.dart'; // Ensure correct import path
import '../widgets/PrimaryButton.dart'; // Import PrimaryButton
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> resetPassword() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match!")),
      );
      return;
    }

    final response = await http.post(
      Uri.parse("http://your-backend-url/reset-password"), // Replace with actual backend URL
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": widget.email, "newPassword": passwordController.text}),
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CongratulationsScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error resetting password!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Reset Password",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A237E)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                "Enter your new password below",
                style: TextStyle(fontSize: 14, color: Colors.teal),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              CustomInputField(
                controller: passwordController,
                hint: "New Password",
                isPassword: true,
                icon: Icons.lock,
              ),
              const SizedBox(height: 20),
              CustomInputField(
                controller: confirmPasswordController,
                hint: "Confirm Password",
                isPassword: true,
                icon: Icons.lock,
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                text: "Reset Password",
                onPressed: resetPassword,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Color(0xFF1A237E), fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
