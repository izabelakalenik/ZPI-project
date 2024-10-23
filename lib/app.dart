import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zpi_project/languages/localization_utils.dart';
import 'package:zpi_project/screens/register_screen/welcome_screen.dart';
import 'package:zpi_project/screens/start_screen.dart';
import 'package:zpi_project/styles/theme.dart';

import 'database_configuration/authentication/authentication_service.dart';
import 'languages/feedback/custom_delegate.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    LocalizationUtils.instance.addListener(_onLocaleChanged);
    LocalizationUtils.instance.initialize();
  }

  @override
  void dispose() {
    LocalizationUtils.instance.removeListener(_onLocaleChanged);
    super.dispose();
  }

  void _onLocaleChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BetterFeedback(
        localeOverride: LocalizationUtils.instance.locale,
        localizationsDelegates: [CustomFeedbackLocalizationsDelegate()],
        child: MaterialApp(
          theme: mainTheme,
          locale: LocalizationUtils.instance.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: _getInitialScreen(),
        )
    );
  }
}

Widget _getInitialScreen() {
  final AuthenticationService authService = AuthenticationService();
  final user = authService.getCurrentUser();
  if (user != null) {
    return const WelcomeScreen();
  } else {
    return const StartScreen();
  }
}
