import 'package:flutter/material.dart';
import 'package:zpi_project/screens/start_screen.dart';
import 'theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZPI project',
      theme: mainTheme,
      home: const StartScreen(),
    );
  }
}