import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zpi_project/screens/setting_screens/about_authors_screen.dart';
import 'package:zpi_project/screens/setting_screens/language_dialog.dart';
import 'package:zpi_project/screens/setting_screens/notifications_screen.dart';
import 'package:zpi_project/screens/setting_screens/policy_screen.dart';
import 'package:zpi_project/screens/setting_screens/report_problem_screen.dart';

import '../../styles/layouts.dart';
import '../../utils/check_login_status.dart';
import '../../widgets/nav_drawer.dart';
import 'edit_profile_screen/edit_profile_bloc.dart';
import 'edit_profile_screen/edit_profile_screen.dart';
import 'logout_dialog.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus(context);
  }

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
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      drawer: NavDrawer(),
      appBar: CustomAppBar(text: localizations.settings),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            // Account Section
            SectionCard(
              title: localizations.account,
              items: [
                MenuItem(
                  icon: Icons.person,
                  label: localizations.edit_profile,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => EditProfileBloc(),
                          child: const EditProfileScreen(),
                        ),
                      ),
                    );
                  },
                ),
                MenuItem(
                  icon: Icons.language,
                  label: localizations.language,
                  onTap: () {
                    showLanguageDialog(context);
                  },
                ),
                MenuItem(
                  icon: Icons.notifications,
                  label: localizations.notifications,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationsScreen()),
                    );
                  },
                ),
                MenuItem(
                  icon: Icons.privacy_tip,
                  label: localizations.privacy_policy,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PolicyScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // About Section
            SectionCard(
              title: localizations.more,
              items: [
                MenuItem(
                  icon: Icons.help_outline,
                  label: localizations.about_authors,
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
              title: localizations.actions,
              items: [
                MenuItem(
                  icon: Icons.report,
                  label: localizations.report,
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
                  label: localizations.logout,
                  onTap: () {
                    showLogOutDialog(context);
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
