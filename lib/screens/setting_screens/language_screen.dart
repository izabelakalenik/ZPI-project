import 'package:flutter/material.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Language',
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
