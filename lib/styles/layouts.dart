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
  final VoidCallback? onPressed; // Allow null for onPressed
  final Color backgroundColor;

  const Button({super.key, required this.text, required this.onPressed, this.backgroundColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 70,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          // padding: const EdgeInsets.symmetric(vertical: 16.0),
          minimumSize: const Size(150, 50),
          side: const BorderSide(color: Colors.white, width: 1.5),
          backgroundColor: backgroundColor.withOpacity(0.2),
          foregroundColor: Colors.white,
          textStyle: Theme.of(context).textTheme.titleLarge,
          elevation: 0,
        ),
        child: text,
      ),
    );
  }
}

class SwipeButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const SwipeButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.black.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Icon(icon, size: 25, color: Colors.white),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const CustomAppBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: AppBar(
        title: Text(
          text,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            shadows: [
              Shadow(
                offset: Offset(1.0, 2.0),
                blurRadius: 3.0,
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
        ),
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
      ),
    );

  }

  // Implement the preferredSize getter to define the app bar size
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
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
    super.key,
  });

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



