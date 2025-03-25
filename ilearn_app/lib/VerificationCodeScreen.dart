import 'package:flutter/material.dart';
import 'ResetPassword.dart'; // Ensure this file contains the ResetPasswordScreen class
import '../widgets/custom_input_field.dart';
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
  bool isLoading = false;

  Future<void> verifyOtp() async {
    if (!isOtpEntered || isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse("https://your-backend-url/verify-otp"),
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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> resendOtp() async {
    setState(() {
      isLoading = true;
    });
    
    try {
      await http.post(
        Uri.parse("https://your-backend-url/resend-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": widget.email}),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP Resent Successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/ilearn_logo.png', height: 40),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Enter OTP',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF1A237E)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'A verification code has been sent to your email',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Image.asset('assets/images/otp_verification.png', height: 220),
              const SizedBox(height: 40),
              CustomInputField(
                controller: otpController,
                icon: Icons.lock_outline,
                hint: 'Enter OTP',
                onChanged: (value) {
  setState(() {
    isOtpEntered = value.length == 6;
  });
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: (isOtpEntered && !isLoading) ? () => verifyOtp() : null,

  child: Text(isLoading ? 'Verifying...' : 'Verify'),
),
              const SizedBox(height: 16),
              TextButton(
                onPressed: resendOtp,
                child: const Text(
                  'Resend OTP',
                  style: TextStyle(color: Color(0xFF1A237E), fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}