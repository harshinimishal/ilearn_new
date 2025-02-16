import 'package:flutter/material.dart';
import '/MainPage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFF121F49),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ilearn_main_logo.png', // Ensure this path is correct
              height: 150,
              width: 150,
              errorBuilder: (context, error, stackTrace) {
                return const Text(
                  'Logo not found',
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
