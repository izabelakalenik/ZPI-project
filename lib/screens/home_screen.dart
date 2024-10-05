import 'package:flutter/material.dart';

import '../styles/layouts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return MainLayout(child: HomeScreenContent());
  }
}

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
          title: Text(
            'MoviePop',
            style: theme.textTheme.displayMedium,
          ),
          actions: <Widget>[
            ///TO DO: POPUP MENU BUTTON
          ]
      ),
    );
  }
}
