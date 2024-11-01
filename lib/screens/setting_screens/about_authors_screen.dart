import 'package:flutter/material.dart';
import '../../styles/layouts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/check_login_status.dart';
import '../../widgets/contact_info.dart';

class AboutAuthorsScreen extends StatefulWidget {
  const AboutAuthorsScreen({super.key});

  @override
  State<AboutAuthorsScreen> createState() => _AboutAuthorsScreenState();
}

class _AboutAuthorsScreenState extends State<AboutAuthorsScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus(context);
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(child: const AboutAuthorsScreenContent());
  }

}

class AboutAuthorsScreenContent extends StatelessWidget {
  const AboutAuthorsScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBar(text: localizations.authors),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image(
                image: AssetImage('assets/authors/cat_avatar.png'),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              localizations.authors_text,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 50),
            ContactInfo(),
          ],
        ),
      ),
    );
  }
}
