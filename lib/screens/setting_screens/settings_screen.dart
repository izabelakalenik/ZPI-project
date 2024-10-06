import 'package:flutter/material.dart';
import 'package:zpi_project/screens/setting_screens/about_authors_screen.dart';
import 'package:zpi_project/screens/setting_screens/language_screen.dart';
import 'package:zpi_project/screens/setting_screens/notifications_screen.dart';
import 'package:zpi_project/screens/setting_screens/report_problem_screen.dart';

import '../../styles/layouts.dart';
import '../../widgets/nav-drawer.dart';
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
    final theme = Theme.of(context);

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text(
          'Settings',
          style: theme.textTheme.displayMedium?.copyWith(
            shadows: [
              Shadow(
                offset: Offset(1.0, 2.0),
                blurRadius: 3.0,
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
        ),
        iconTheme: theme.iconTheme,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Account Section
            _buildSectionCard(
              context,
              title: 'Account',
              items: [
                _buildMenuItem(Icons.person, 'Edit Profile', context, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
                }),
                _buildMenuItem(Icons.language, 'Language', context, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageScreen()));
                }),
                _buildMenuItem(Icons.notifications, 'Notifications', context, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsScreen()));
                }),
              ],
            ),
            const SizedBox(height: 20),

            // About Section
            _buildSectionCard(
              context,
              title: 'More About Us c:',
              items: [
                _buildMenuItem(Icons.help_outline, 'About Authors', context, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutAuthorsScreen()));
                }),
              ],
            ),
            const SizedBox(height: 20),

            // Actions Section
            _buildSectionCard(
              context,
              title: 'Actions',
              items: [
                _buildMenuItem(Icons.report, 'Report a problem', context, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReportProblemScreen()));
                }),
                _buildMenuItem(Icons.logout, 'Log out', context, () {
                  // Add log out functionality
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context, {required String title, required List<Widget> items}) {
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

  Widget _buildMenuItem(IconData icon, String label, BuildContext context, VoidCallback onTap) {
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
