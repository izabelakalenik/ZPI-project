import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zpi_project/screens/setting_screens/about_authors_screen.dart';
import 'package:zpi_project/screens/setting_screens/language_screen.dart';
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
    return MainLayout(child: SettingsScreenContent());
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
            _buildSectionCard(
              context,
              title: AppLocalizations.of(context)!.account,
              items: [
                _buildMenuItem(Icons.person,
                    AppLocalizations.of(context)!.edit_profile, context, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen()));
                }),
                _buildMenuItem(Icons.language,
                    AppLocalizations.of(context)!.language, context, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LanguageScreen()));
                }),
                _buildMenuItem(Icons.notifications,
                    AppLocalizations.of(context)!.notifications, context, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationsScreen()));
                }),
              ],
            ),
            const SizedBox(height: 20),

            // About Section
            _buildSectionCard(
              context,
              title: AppLocalizations.of(context)!.more,
              items: [
                _buildMenuItem(Icons.help_outline,
                    AppLocalizations.of(context)!.authors, context, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AboutAuthorsScreen()));
                }),
              ],
            ),
            const SizedBox(height: 20),

            // Actions Section
            _buildSectionCard(
              context,
              title: AppLocalizations.of(context)!.actions,
              items: [
                _buildMenuItem(
                    Icons.report, AppLocalizations.of(context)!.report, context,
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReportProblemScreen()));
                }),
                _buildMenuItem(
                    Icons.logout, AppLocalizations.of(context)!.logout, context,
                    () {
                  // Add log out functionality
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context,
      {required String title, required List<Widget> items}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      color: Colors.white.withOpacity(0.2),
      shadowColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Column(children: items),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      IconData icon, String label, BuildContext context, VoidCallback onTap) {
    return InkWell(
      onTap: onTap, // Handle tap
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 15),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
