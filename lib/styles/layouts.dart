import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2D0027), Color(0xFF68005A), Color(0xFFC3584B)],
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
  final double? width;
  final double? height;

  const Button(
      {super.key,
      required this.text,
      required this.onPressed,
      this.backgroundColor = Colors.white,
      this.width = 150,
      this.height = 50});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          minimumSize: const Size(150, 50),
          backgroundColor: backgroundColor.withOpacity(0.3),
          foregroundColor: Colors.white,
          side: BorderSide(
              color: backgroundColor == Colors.black
                  ? Colors.transparent
                  : Colors.white,
              width: 1.5),
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
  final String heroTag;

  const SwipeButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
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
  final TextEditingController? controller;
  final String labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? hintText; // Allow suffix icon
  final String? initialValue;
  final bool readOnly;

  const CustomTextField({
    this.controller,
    this.initialValue,
    required this.labelText,
    this.obscureText = false,
    this.suffixIcon,
    this.hintText,
    this.readOnly = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      style: const TextStyle(color: Colors.white), // Text color
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: Colors.white70), // Gray border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide:
              const BorderSide(color: Colors.white70), // Gray border on focus
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
              color: Colors.white70), // Gray border when enabled
        ),
        suffixIcon: suffixIcon, // Use the optional suffix icon
      ),
    );
  }
}

class CustomSocialLoginButton extends StatelessWidget {
  final String text;
  final SocialLoginButtonType buttonType;
  final VoidCallback onPressed;

  const CustomSocialLoginButton({
    required this.text,
    required this.buttonType,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SocialLoginButton(
      text: text,
      textColor: Colors.white,
      backgroundColor: Colors.black.withOpacity(0.2),
      buttonType: buttonType,
      imageWidth: 20,
      borderRadius: 15,
      onPressed: onPressed,
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const SectionCard({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      color: Colors.white.withOpacity(0.2),
      shadowColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Column(children: items),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const MenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Handle tap
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 15),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}