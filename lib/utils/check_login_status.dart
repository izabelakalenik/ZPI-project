import 'package:flutter/material.dart';

import '../database_configuration/authentication_service.dart';
import '../screens/start_screen.dart';

final AuthenticationService _authService = AuthenticationService();

Future<void> checkLoginStatus(context) async {
  final user = _authService.getCurrentUser();
  if (user == null) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => StartScreen()),
          (Route<dynamic> route) => false,
    );
  }
}