import 'package:flutter/material.dart';
import '/ResetPassword.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VerificationCodeScreen extends StatefulWidget {
  final String email;
  const VerificationCodeScreen({super.key, required this.email});

  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final TextEditingController otpController = TextEditingController();
  bool isOtpEntered = false;

  Future<void> verifyOtp() async {
    final response = await http.post(
      Uri.parse("http://your-backend-url/verify-otp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": widget.email, "otp": otpController.text}),
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPasswordScreen(email: widget.email),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP. Try again.")),
      );
    }
  }

  Future<void> resendOtp() async {
    await http.post(
      Uri.parse("http://your-backend-url/resend-otp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": widget.email}),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("OTP Resent Successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Image.asset('assets/images/ilearn_logo.png', height: 30),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                const Text("Enter OTP", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                TextField(
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  onChanged: (value) {
                    setState(() {
                      isOtpEntered = value.length == 6;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: isOtpEntered ? verifyOtp : null,
                  child: const Text("Verify"),
                ),
                TextButton(onPressed: resendOtp, child: const Text("Resend OTP")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
