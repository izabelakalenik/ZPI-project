import 'package:flutter/material.dart';

final mainTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
  scaffoldBackgroundColor: Colors.transparent,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
  ),
  fontFamily: 'Sen',
  navigationBarTheme:
      NavigationBarThemeData(backgroundColor: Colors.black.withOpacity(0.6)),
  iconTheme: IconThemeData(color: Colors.white, size: 30),
  textTheme: TextTheme(
    displaySmall: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    titleLarge: TextStyle(
      color: Colors.white,
    ),
    titleSmall: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.white),
    headlineLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    labelLarge: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    labelMedium: TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
    labelSmall: TextStyle(fontSize: 12, color: Colors.grey),
    bodyMedium: TextStyle(fontSize: 18, color: Colors.white),
  ),
);
