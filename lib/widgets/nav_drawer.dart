import 'package:flutter/material.dart';
import 'package:zpi_project/screens/home_screen.dart';
import '../screens/setting_screens/settings_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      backgroundColor: theme.navigationBarTheme.backgroundColor,
      child: ListView(
        // TODO: extract it somehow
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        children: <Widget>[
          Center(
            child: DrawerHeader(
              child: Text(
                AppLocalizations.of(context)!.menu,
                style: theme.textTheme.headlineLarge,
              ),
            ),
          ),
          ListTile(
            title: Text(
                AppLocalizations.of(context)!.home,
                style: theme.textTheme.bodyLarge),
            // for now clicking on those buttons doesn't do anything
            // in the future change this line to navigate to a proper screen
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              ),
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.liked,
              style: theme.textTheme.bodyLarge,
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.connect,
              style: theme.textTheme.bodyLarge,
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.settings,
              style: theme.textTheme.bodyLarge,
            ),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              ),
            },
          ),
        ],
      ),
    );
  }
}