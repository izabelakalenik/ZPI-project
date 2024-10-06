import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({required this.child, super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE7C039), Color(0xFFA80092)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: child,
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final Widget text;
  final VoidCallback onPressed;

  const Button({required this.text, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 150,
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white, width: 1.5),
          foregroundColor: Colors.white,
          textStyle: Theme.of(context).textTheme.titleLarge,
        ),
        child: text,
      ),
    );
  }
}

class ElevatedCustomButton extends StatelessWidget {
  final Widget text;
  final VoidCallback? onPressed; // Allow null for onPressed

  const ElevatedCustomButton({required this.text, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          // padding: const EdgeInsets.symmetric(vertical: 16.0),
          minimumSize: const Size(150, 50),
          side: const BorderSide(color: Colors.white, width: 1.5),
          backgroundColor: Colors.white.withOpacity(0.2),
          foregroundColor: Colors.white,
          textStyle: Theme.of(context).textTheme.titleLarge,
          elevation: 0,
        ),
        child: text,
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final Widget? suffixIcon; // Allow suffix icon

  const CustomTextField({
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.suffixIcon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white), // Text color
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white), // Label color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: Colors.white70), // Gray border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: Colors.white70), // Gray border on focus
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: Colors.white70), // Gray border when enabled
        ),
        suffixIcon: suffixIcon, // Use the optional suffix icon
      ),
    );
  }
}



