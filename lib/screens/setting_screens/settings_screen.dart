import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zpi_project/screens/setting_screens/about_authors_screen.dart';
import 'package:zpi_project/screens/setting_screens/language_dialog.dart';
import 'package:zpi_project/screens/setting_screens/notifications_screen.dart';
import 'package:zpi_project/screens/setting_screens/report_problem_screen.dart';

import '../../styles/layouts.dart';
import '../../widgets/nav_drawer.dart';
import 'edit_profile_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(child: const SettingsScreenContent());
  }
}

class SettingsScreenContent extends StatelessWidget {
  const SettingsScreenContent({super.key});

  void someAction() {}

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context); // Fetch localizations

    return Scaffold(
      drawer: NavDrawer(),
      appBar: CustomAppBar(text: localizations.settings), // Use localizations variable
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            // Account Section
            SectionCard(
              title: localizations.account, // Use localizations variable
              items: [
                MenuItem(
                  icon: Icons.person,
                  label: localizations.edit_profile, // Use localizations variable
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen()),
                    );
                  },
                ),
                MenuItem(
                  icon: Icons.language,
                  label: localizations.language, // Use localizations variable
                  onTap: () {
                    showLanguageDialog(context);
                  },
                ),
                MenuItem(
                  icon: Icons.notifications,
                  label: localizations.notifications, // Use localizations variable
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationsScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // About Section
            SectionCard(
              title: localizations.more, // Use localizations variable
              items: [
                MenuItem(
                  icon: Icons.help_outline,
                  label: localizations.authors, // Use localizations variable
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AboutAuthorsScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Actions Section
            SectionCard(
              title: localizations.actions, // Use localizations variable
              items: [
                MenuItem(
                  icon: Icons.report,
                  label: localizations.report, // Use localizations variable
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReportProblemScreen()),
                    );
                  },
                ),
                MenuItem(
                  icon: Icons.logout,
                  label: localizations.logout, // Use localizations variable
                  onTap: () {
                    // Add log out functionality
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
