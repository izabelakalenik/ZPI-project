import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../languages/localization_utils.dart';
import '../../styles/layouts.dart';

void showLanguageDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
        child: const LanguageDialog(),
      );
    },
  );
}

class LanguageDialog extends StatefulWidget {
  const LanguageDialog({super.key});

  @override
  LanguageDialogState createState() => LanguageDialogState();
}

class LanguageDialogState extends State<LanguageDialog> {
  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: const Color(0xFFFFC8DD).withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              localizations.select_language,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
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
            MenuItem(
              icon: Icons.language,
              label: localizations.polish,
              onTap: () {
                _changeLanguage(const Locale("pl"));
              },
            ),
            MenuItem(
              icon: Icons.language,
              label: localizations.english,
              onTap: () {
                _changeLanguage(const Locale("en"));
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4C0024).withOpacity(0.3),
                foregroundColor: Colors.white,
                textStyle: Theme.of(context).textTheme.titleLarge,
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(localizations.cancel),
            ),
          ],
        ),
      ),
    );
  }

  void _changeLanguage(Locale locale) {
    LocalizationUtils.instance
        .changeLocale(locale: locale, systemDefault: false);
    Navigator.pop(context);
  }
}
