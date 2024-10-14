import 'package:flutter/material.dart';
import 'package:zpi_project/screens/setting_screens/about_authors_screen.dart';
import 'package:zpi_project/screens/setting_screens/language_screen.dart';
import 'package:zpi_project/screens/setting_screens/notifications_screen.dart';
import 'package:zpi_project/screens/setting_screens/report_problem_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    return Scaffold(
      drawer: NavDrawer(),
      appBar: CustomAppBar(text: AppLocalizations.of(context)!.settings),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            // Account Section
            SectionCard(
              title: AppLocalizations.of(context)!.account,
              items: [
                MenuItem(
                  icon: Icons.person,
                  label: AppLocalizations.of(context)!.edit_profile,
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
                  label: AppLocalizations.of(context)!.language,
                  onTap: () {
                    showLanguageDialog(context);
                  },
                ),
                MenuItem(
                  icon: Icons.notifications,
                  label: AppLocalizations.of(context)!.notifications,
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
              title: AppLocalizations.of(context)!.more,
              items: [
                MenuItem(
                  icon: Icons.help_outline,
                  label: AppLocalizations.of(context)!.authors,
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
              title: AppLocalizations.of(context)!.actions,
              items: [
                MenuItem(
                  icon: Icons.report,
                  label: AppLocalizations.of(context)!.report,
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
                  label: AppLocalizations.of(context)!.logout,
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
