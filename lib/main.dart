import 'package:flutter/material.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app.dart';
import 'languages/feedback_language.dart';
import 'languages/localization_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalizationUtils.instance.initialize();

  runApp(
      BetterFeedback(
        localeOverride: LocalizationUtils.instance.locale,
        localizationsDelegates: [
          CustomFeedbackLocalizationsDelegate(),
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        child: const App(),
      )
  );
}
