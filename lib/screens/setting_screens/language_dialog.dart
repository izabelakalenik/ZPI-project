import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zpi_project/widgets/dialog.dart';
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
  State<LanguageDialog> createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  String? selectedLanguage;


  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return PopupWindow(
      text: localizations.select_language,
      child: Column(
        children: [
          MenuItem(
            icon: Icons.language,
            label: localizations.polish,
            onTap: () {
              _changeLanguage(const Locale("pl", "PL"));
            },
          ),
          MenuItem(
            icon: Icons.language,
            label: localizations.english,
            onTap: () {
              _changeLanguage(const Locale("en", "US"));
            },
          ),
          const SizedBox(height: 20),
          PopupButton(
            onPressed: () => Navigator.pop(context),
            text: localizations.cancel,
          ),
        ],
      ),
    );
  }

  void _changeLanguage(Locale locale) {
    LocalizationUtils.instance
        .changeLocale(locale: locale, systemDefault: false);
    Navigator.pop(context);
  }
}
