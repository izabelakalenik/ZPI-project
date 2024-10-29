import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zpi_project/screens/connect_screen/connect_screen.dart';
import 'package:zpi_project/screens/home_screen/home_screen.dart';
import 'package:zpi_project/screens/home_screen/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/liked_movies_screen.dart';
import '../screens/setting_screens/settings_screen.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

    return Drawer(
      backgroundColor: theme.navigationBarTheme.backgroundColor,
      child: ListView(
        // TODO: extract it somehow
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        children: <Widget>[
          Center(
            child: DrawerHeader(
              child: Text(
                localizations.menu,
                style: theme.textTheme.headlineLarge,
              ),
            ),
          ),
          ListTile(
            title: Text(
              localizations.home,
              style: theme.textTheme.bodyLarge,
            ),
            // For now, clicking on those buttons doesn't do anything
            // In the future, change this line to navigate to a proper screen
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (_) => HomeBloc()..add(LoadInitialCards()),
                          child: const HomeScreen(),
                        )),
              ),
            },
          ),
          ListTile(
            title: Text(
              localizations.liked,
              style: theme.textTheme.bodyLarge,
            ),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LikedMoviesScreen()),
              ),
            },
          ),
          ListTile(
            title: Text(
              localizations.connect_with_user,
              style: theme.textTheme.bodyLarge,
            ),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConnectScreen()),
              ),
            },
          ),
          ListTile(
            title: Text(
              localizations.settings,
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
