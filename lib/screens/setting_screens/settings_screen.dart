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
            buildSectionCard(
              context,
              title: AppLocalizations.of(context)!.account,
              items: [
                buildMenuItem(Icons.person,
                    AppLocalizations.of(context)!.edit_profile, context, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen()));
                }),
                buildMenuItem(
                  Icons.language,
                  AppLocalizations.of(context)!.language,
                  context,
                      () {showLanguageDialog(context);},
                ),
                buildMenuItem(Icons.notifications,
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
            buildSectionCard(
              context,
              title: AppLocalizations.of(context)!.more,
              items: [
                buildMenuItem(Icons.help_outline,
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
            buildSectionCard(
              context,
              title: AppLocalizations.of(context)!.actions,
              items: [
                buildMenuItem(
                    Icons.report, AppLocalizations.of(context)!.report, context,
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReportProblemScreen()));
                }),
                buildMenuItem(
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
}
