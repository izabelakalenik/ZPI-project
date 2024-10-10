import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zpi_project/screens/start_screen.dart';
import 'package:zpi_project/styles/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mainTheme,
      /*If you want the app to automatically switch between English and Polish
      based on the system language, you can omit the locale parameter entirely.
      The app will automatically choose the appropriate locale from the
      supportedLocales list based on the device's language settings.*/
      // locale: const Locale('pl'), // Uncomment if u want a polish language
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('pl'), // Polish
      ],
      // To see other screens, change home attribute --> home: const StartScreen(),
      home: const StartScreen(),
    );
  }
}
