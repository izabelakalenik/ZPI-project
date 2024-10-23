import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zpi_project/screens/start_screen.dart';
import 'package:zpi_project/styles/layouts.dart';
import 'package:zpi_project/widgets/dialog.dart';

import '../../database_configuration/authentication_service.dart';


void showLogOutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
        child: const LogOutDialog(),
      );
    },
  );
}


class LogOutDialog extends StatefulWidget {
  const LogOutDialog({super.key});

  @override
  State<LogOutDialog> createState() => _LogOutDialogState();
}

class _LogOutDialogState extends State<LogOutDialog> {

  final AuthenticationService _authService = AuthenticationService(); // Initialize service

  Future<void> _signOut(BuildContext context) async {
    try {
      await _authService.signOutUser();
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const StartScreen()),
                (route) => false,
        );
      }
    } catch (error) {
      debugPrint("ERROR DURING LOGOUT: {$error}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return PopupWindow(
      text: localizations.logout,
      child: Column(
        children: [
          Text(
            localizations.logout_text,
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PopupButton(
                onPressed: () => _signOut(context), // Call sign out method
                text: localizations.yes,
              ),
              const SizedBox(width: 30),
              PopupButton(
                onPressed: () => Navigator.pop(context),
                text: localizations.no,
              ),
            ],
          ),
        ],
      ),
    );
  }
}