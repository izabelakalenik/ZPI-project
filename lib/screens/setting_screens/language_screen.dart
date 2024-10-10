import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../styles/layouts.dart';


void showLanguageDialog(BuildContext context){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const LanguageDialog();
    },
  );
}

class LanguageDialog extends StatefulWidget {
  const LanguageDialog({super.key});

  @override
  _LanguageDialogState createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  String? selectedLanguage;

  void _setLanguage(String language) {
    setState(() {
      selectedLanguage = language;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Language changed to $language')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.pink.withOpacity(0.8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LanguageDialogContent(
          selectedLanguage: selectedLanguage,
          onLanguageSelected: _setLanguage,
        ),
      ),
    );
  }
}

class LanguageDialogContent extends StatelessWidget {
  final String? selectedLanguage;
  final Function(String) onLanguageSelected;

  const LanguageDialogContent({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min, // Make the dialog wrap its content
      children: [
        Text(
          AppLocalizations.of(context)!.select_language,
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
        buildLanguageMenuItem(AppLocalizations.of(context)!.polish, context),
        buildLanguageMenuItem(AppLocalizations.of(context)!.english, context),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildLanguageMenuItem(String language, BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.language, color: Colors.white),
      title: Text(
        language,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: () => onLanguageSelected(language),
    );
  }
}
