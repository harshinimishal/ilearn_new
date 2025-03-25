import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/language_provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LanguageProvider>(context);
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), // Increased height for better positioning
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 10), // Moves logo slightly down
            child: Image.asset(
              'assets/images/ilearn_logo.png',
              fit: BoxFit.contain,
              width: 120,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
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
          ),
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 360, // Reduced height to prevent overflow
                child: Image.asset(
                  'assets/images/blue_ecllipse.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
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
                      const SizedBox(height: 15),
                      const Text(
                        'Embark on an engaging and interactive journey to explore, learn, and grow like never before!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00A859),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
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
                      ),
                      const SizedBox(height: 20),

                      // Language Dropdown
                      DropdownButton<String>(
                        value: provider.locale.languageCode,
                        dropdownColor: Colors.white,
                        style: const TextStyle(color: Colors.black),
                        items: const [
                          DropdownMenuItem(value: 'en', child: Text('English')),
                          DropdownMenuItem(value: 'hi', child: Text('Hindi')),
                          DropdownMenuItem(value: 'fr', child: Text('French')),
                        ],
                        onChanged: (value) {
                          if (value != null) provider.setLocale(value);
                        },
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
