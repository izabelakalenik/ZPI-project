import 'package:flutter/material.dart';

class JoinerScreen extends StatelessWidget {
  const JoinerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'About Authors',
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}