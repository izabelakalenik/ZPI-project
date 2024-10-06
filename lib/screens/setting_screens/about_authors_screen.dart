import 'package:flutter/material.dart';

class AboutAuthorsScreen extends StatelessWidget {
  const AboutAuthorsScreen({Key? key}) : super(key: key);

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
