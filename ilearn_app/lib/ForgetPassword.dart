import 'package:flutter/material.dart';
import 'VerificationCodeScreen.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/PrimaryButton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isEmailValid = false;

  Future<void> sendOtp() async {
    if (!isEmailValid) return;

    final response = await http.post(
      Uri.parse("http://your-server-ip:5000/send-otp"), // Replace with actual backend URL
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": emailController.text}),
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationCodeScreen(email: emailController.text),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to send OTP. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Image.asset('assets/images/ilearn_logo.png', height: 30),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Forget Password',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A237E)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Enter your email account to reset password',
                      style: TextStyle(fontSize: 14, color: Colors.teal),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    Image.asset('assets/images/forget_password.png', height: 200),
                    const SizedBox(height: 40),
                    CustomInputField(
                      controller: emailController,
                      icon: Icons.email_outlined,
                      hint: 'Enter your email',
                      onChanged: (value) {
                        setState(() {
                          isEmailValid = value.contains('@') && value.contains('.');
                        });
                      },
                    ),
                    const SizedBox(height: 40),
                    PrimaryButton(
                      text: 'Continue',
                      onPressed: isEmailValid ? () => sendOtp() : () {},
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Color(0xFF1A237E), fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
