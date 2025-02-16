import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Image.asset(
            'assets/images/ilearn_logo.png',
            fit: BoxFit.contain,
            width: 100,
            height: 100,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  'assets/images/main_page_design.png',
                  fit: BoxFit.contain,
                  height: 260,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Image not found');
                  },
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Image.asset(
                'assets/images/blue_ecllipse.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 420,
              ),
              Positioned.fill(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      const Text(
                        'The only study app you’ll ever need',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PoltawskiNowy',
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Embark on an engaging and interactive journey to explore, learn, and grow like never before!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00A859),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup-login');
                        },
                        child: const Text(
                          'GET STARTED',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
