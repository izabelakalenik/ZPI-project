import 'dart:ui';
import 'package:feedback/feedback.dart';

class CustomFeedbackLocalizationsDelegate
    extends GlobalFeedbackLocalizationsDelegate {
  @override
  // ignore: overridden_fields
  final supportedLocales = <Locale, FeedbackLocalizations>{
    const Locale('pl'): _PolishFeedbackLocalizations(),
    const Locale('en'): _EnglishFeedbackLocalizations(),
  };
}

class _PolishFeedbackLocalizations implements FeedbackLocalizations {

  @override
  String get draw => 'Rysuj';

  @override
  String get feedbackDescriptionText => 'Jaki błąd napotkałeś?';

  @override
  String get navigate => 'Nawiguj';

  @override
  String get submitButtonText => 'Wyślij';
}

class _EnglishFeedbackLocalizations implements FeedbackLocalizations {
  @override
  String get draw => 'Draw';

  @override
  String get feedbackDescriptionText => "What's wrong?";

  @override
  String get navigate => 'Navigate';

  @override
  String get submitButtonText => 'Send';
}