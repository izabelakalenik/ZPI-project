import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zpi_project/screens/home_screen.dart';
import 'package:zpi_project/styles/theme.dart';
import 'package:zpi_project/languages/localization_utils.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState(); // Change _AppState to AppState
}

class AppState extends State<App> { // Change class name from _AppState to AppState
  @override
  void initState() {
    super.initState();
    LocalizationUtils.instance.addListener(_onLocaleChanged);
    LocalizationUtils.instance.initialize(); // Initialize the locale
  }

  @override
  void dispose() {
    LocalizationUtils.instance.removeListener(_onLocaleChanged);
    super.dispose();
  }

  void _onLocaleChanged() {
    setState(() {}); // Rebuild the widget when the locale changes
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mainTheme,
      locale: LocalizationUtils.instance.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeScreen(),
    );
  }
}
