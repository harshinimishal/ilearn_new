import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'TermsConditionsScreen.dart';
import 'ForgetPassword.dart';
import '../widgets/custom_input_field.dart';

class SignUpLoginPage extends StatefulWidget {
  const SignUpLoginPage({super.key});

  @override
  State<SignUpLoginPage> createState() => _SignUpLoginPageState();
}

class _SignUpLoginPageState extends State<SignUpLoginPage> {
  bool isLogin = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  bool _isChecked = false;

  /// 🔹 **Login Function**
  Future<void> loginUser() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacementNamed(context, '/home');
      print("✅ Login successful!");
      
    } catch (e) {
      print("❌ Login failed: ${e.toString()}");
    }
  }

  /// 🔹 **Signup Function with Firestore**
  Future<void> signUpUser() async {
    if (_isChecked) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        // Store additional user details in Firestore
        await _firestore.collection("users").doc(userCredential.user!.uid).set({
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "school": schoolController.text.trim(),
          "createdAt": DateTime.now(),
        });
        Navigator.pushReplacementNamed(context, '/home');
        print("✅ Signup successful!");
      } catch (e) {
        print("❌ Signup failed: ${e.toString()}");
      }
    } else {
      print("Please agree to terms and conditions");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              // Logo
              Row(
                children: [
                  Image.asset('assets/images/ilearn_logo.png', height: 30),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to iLEARN',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 18, 31, 73),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Sign up or log in to embark on an interactive journey with our app!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 9, 125, 102),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),

              // Toggle Login/Signup
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isLogin = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isLogin ? const Color.fromARGB(255, 18, 31, 73) : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: isLogin ? FontWeight.bold : FontWeight.normal,
                            color: isLogin ? const Color.fromARGB(255, 18, 31, 73) : Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isLogin = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: !isLogin ? const Color.fromARGB(255, 18, 31, 73) : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: !isLogin ? FontWeight.bold : FontWeight.normal,
                            color: !isLogin ? const Color.fromARGB(255, 18, 31, 73) : Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Form Fields
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 229, 239, 241),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
                ),
                child: Column(
                  children: [
                    if (!isLogin) ...[
                      CustomInputField(
                        controller: nameController,
                        hint: "Enter your name",
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 15),
                    ],

                    // Email field
                    CustomInputField(
                      controller: emailController,
                      hint: "Enter your email",
                      icon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 15),

                    if (!isLogin) ...[
                      // School field for Sign Up
                      CustomInputField(
                        controller: schoolController,
                        hint: "Enter your School name",
                        icon: Icons.school_outlined,
                      ),
                      const SizedBox(height: 15),
                    ],

                    // Password field
                    CustomInputField(
                      controller: passwordController,
                      hint: "Enter a Password",
                      icon: Icons.lock_outline,
                    ),
                    const SizedBox(height: 20),

                    // Terms and Conditions (only for Sign Up)
                    if (!isLogin) ...[
                      Row(
                        children: [
                          Checkbox(
                            value: _isChecked,
                            onChanged: (value) => setState(() => _isChecked = value!),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // Navigate to the TermsConditionsScreen when tapped
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TermsConditionsScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'By creating an account you have to agree with our terms & conditions.',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 127, 127, 127),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 10),

                    if (isLogin)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgetPasswordScreen()),
                            );
                          },
                          child: const Text("Forgot password?", style: TextStyle(color: Colors.grey)),
                        ),
                      ),
                  ],
                ),
              ),
              
              // Signup/Login Button
              ElevatedButton(
                onPressed: () {
                  if (isLogin) {
                    loginUser();
                  } else {
                    signUpUser();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 18, 31, 73),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(isLogin ? 'Login' : 'Sign up', style: const TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
