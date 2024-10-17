import 'package:flutter/material.dart';
import '../styles/layouts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactInfo extends StatelessWidget{
  const ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

    return SectionCard(
      title: localizations.contact_info,
      items: [
        Row(children: [Icon(Icons.mail_outline_rounded,
            color: Colors.white.withOpacity(0.7), size: 50),
          SizedBox(width: 20),
          Text(
            "moviepop@gmail.com",
            style: theme.textTheme.bodyLarge,
          ),],)

      ],
    );
  }
}