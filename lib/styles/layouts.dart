import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({required this.child, super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE7C039), Color(0xFFA80092)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
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