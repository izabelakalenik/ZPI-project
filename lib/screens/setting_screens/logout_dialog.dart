import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zpi_project/screens/start_screen.dart';



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

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: const Color(0xFFFFC8DD).withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              localizations.logout,
              style: theme.textTheme.displayMedium?.copyWith(
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: const Offset(1.0, 2.0),
                    blurRadius: 3.0,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              localizations.logout_text,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(width: 30),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4C0024).withOpacity(0.3),
                    foregroundColor: Colors.white,
                    textStyle: Theme.of(context).textTheme.titleLarge,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StartScreen()),
                    );
                  },
                  child: Text(localizations.yes), // Provide a valid child widget
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4C0024).withOpacity(0.3),
                    foregroundColor: Colors.white,
                    textStyle: Theme.of(context).textTheme.titleLarge,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(localizations.no),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
}
