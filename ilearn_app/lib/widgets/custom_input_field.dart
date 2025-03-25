import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final Function(String)? onChanged; // Made optional
  final TextInputType? keyboardType;
  final bool isPassword; // Added for password fields
  final Widget? suffixIcon; // Optional suffix icon

  const CustomInputField({
    Key? key,
    required this.controller,
    required this.icon,
    required this.hint,
    this.onChanged,
    this.keyboardType,
    this.isPassword = false, // Default to false
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword, // Now properly defined
      keyboardType: keyboardType,
      onChanged: onChanged, // Optional
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon, // Optional
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
