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
  textTheme: TextTheme(

    displayMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white
    ),

    titleLarge: TextStyle(
      color: Colors.white
    ),

  ),
);
