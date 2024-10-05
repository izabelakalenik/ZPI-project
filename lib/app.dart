import 'package:flutter/material.dart';
import 'package:zpi_project/screens/start_screen.dart';
import 'package:zpi_project/styles/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoviePop',
      theme: mainTheme,
      home: const StartScreen(),
    );
  }
}