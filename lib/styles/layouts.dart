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
            colors: [Color(0xFF25011F), Color(0xFF68005A), Color(0xFFC3584B)],
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
  final Widget? icon;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final double? width;
  final double? height;

  const Button({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.width = 150,
    this.height = 50,
  });

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
              color: backgroundColor == Colors.black ? Colors.transparent : Colors.white,
              width: 1.5),
          textStyle: Theme.of(context).textTheme.titleLarge,
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 0),
            ],
            text,
          ],
        ),
      ),
    );
  }
}

class PopupButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const PopupButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4C0024).withOpacity(0.3),
        foregroundColor: Colors.white,
        textStyle: Theme.of(context).textTheme.titleLarge,
      ),
      onPressed: onPressed,
      child: Text(text),
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
  final double? height;

  const CustomAppBar({super.key, required this.text, this.height = 60.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: AppBar(
        toolbarHeight: height,
        title: Text(
          text,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
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
  Size get preferredSize => Size.fromHeight(height!);
}

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? hintText; // Allow suffix icon
  final String? initialValue;
  final bool readOnly;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    this.controller,
    this.initialValue,
    required this.labelText,
    this.obscureText = false,
    this.suffixIcon,
    this.hintText,
    this.maxLines = 1,
    this.readOnly = false,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      readOnly: readOnly,
      style: const TextStyle(color: Colors.white),
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
          borderSide: const BorderSide(color: Colors.white70), // Gray border on focus
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: Colors.white70), // Gray border when enabled
        ),
        suffixIcon: suffixIcon, // Use the optional suffix icon
      ),
      onChanged: onChanged, // Pass onChanged to the TextFormField
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

class HorizontalLists extends StatelessWidget {
  final List<String> friends;

  const HorizontalLists({
    super.key,
    required this.friends,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.transparent),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: friends.isNotEmpty
          ? SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: friends
              .map(
                (friend) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Text(
                  friend,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
              .toList(),
        ),
      )
          : Center(
        child: Text(
          'No friends joined yet.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white.withOpacity(0.8)),
        ),
      ),
    );
  }
}