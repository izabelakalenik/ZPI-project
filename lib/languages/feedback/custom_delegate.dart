import 'dart:ui';
import 'package:feedback/feedback.dart';
import 'package:zpi_project/languages/feedback/polish_feedback.dart';

import 'english_feedback.dart';

class CustomFeedbackLocalizationsDelegate
    extends GlobalFeedbackLocalizationsDelegate {
  @override
  // ignore: overridden_fields
  final supportedLocales = <Locale, FeedbackLocalizations>{
    const Locale('pl'): PolishFeedbackLocalizations(),
    const Locale('en'): EnglishFeedbackLocalizations(),
  };
}