import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'HomeScreen.dart';
import 'ForgetPassword.dart';
import 'TermsConditionsScreen.dart';
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
  String userType = "Student";

  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
  }

  void checkUserLoggedIn() {
    User? user = _auth.currentUser;
    if (user != null) {
      _firestore.collection("users").doc(user.uid).get().then((userDoc) {
        if (userDoc.exists) {
          String userName = userDoc["name"];
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(userName: userName)),
          );
        }
      });
    }
  }

  Future<void> loginUser() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      DocumentSnapshot userDoc = await _firestore.collection("users").doc(userCredential.user!.uid).get();
      if (userDoc.exists) {
        String userName = userDoc["name"];
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(userName: userName)),
        );
      }
    } catch (e) {
      print("❌ Login failed: ${e.toString()}");
    }
  }

  Future<void> signUpUser() async {
    if (!_isChecked) {
      print("❌ Please agree to the terms and conditions.");
      return;
    }

    bool exists = await emailExists(emailController.text.trim());
    if (exists) {
      print("❌ Email already exists! Try logging in.");
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "school": schoolController.text.trim(),
        "userType": userType,
        "createdAt": DateTime.now(),
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(userName: nameController.text.trim())),
      );
    } catch (e) {
      print("❌ Signup failed: ${e.toString()}");
    }
  }

  Future<bool> emailExists(String email) async {
    final result = await _firestore.collection("users").where("email", isEqualTo: email).get();
    return result.docs.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF36D1DC), Color(0xFF5B86E5)], // Cool gradient effect
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              Image.asset('assets/images/ilearn_logo.png', height: 50), // App logo

              const SizedBox(height: 20),
              Text(
                isLogin ? 'Welcome Back!' : 'Create an Account',
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
              ),

              const SizedBox(height: 10),
              Text(
                isLogin ? 'Log in to continue your learning journey' : 'Join us today and start learning!',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),

              const SizedBox(height: 30),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
                ),
                child: Column(
                  children: [
                    if (!isLogin) CustomInputField(controller: nameController, hint: "Full Name", icon: Icons.person),
                    CustomInputField(controller: emailController, hint: "Email", icon: Icons.email),
                    if (!isLogin) CustomInputField(controller: schoolController, hint: "School Name", icon: Icons.school),
                    CustomInputField(controller: passwordController, hint: "Password", icon: Icons.lock, isPassword: true),

                    const SizedBox(height: 10),
                    const Text("Select Your Role:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChoiceChip(
                          label: const Text("Student"),
                          selected: userType == "Student",
                          onSelected: (selected) => setState(() => userType = "Student"),
                          selectedColor: Colors.blue.shade100,
                        ),
                        const SizedBox(width: 10),
                        ChoiceChip(
                          label: const Text("Teacher"),
                          selected: userType == "Teacher",
                          onSelected: (selected) => setState(() => userType = "Teacher"),
                          selectedColor: Colors.blue.shade100,
                        ),
                      ],
                    ),

                    if (!isLogin)
                      Row(
                        children: [
                          Checkbox(
                            value: _isChecked,
                            onChanged: (value) => setState(() => _isChecked = value!),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TermsConditionsScreen())),
                            child: const Text("I agree to the Terms & Conditions", style: TextStyle(color: Colors.blue)),
                          ),
                        ],
                      ),

                    if (isLogin)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordScreen())),
                          child: const Text("Forgot Password?", style: TextStyle(color: Colors.blue)),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                ),
                onPressed: isLogin ? loginUser : signUpUser,
                child: Text(isLogin ? "Login" : "Sign Up", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),

              TextButton(
                onPressed: () => setState(() => isLogin = !isLogin),
                child: Text(
                  isLogin ? "Don't have an account? Sign up" : "Already have an account? Log in",
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
