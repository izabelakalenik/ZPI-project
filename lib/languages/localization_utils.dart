import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationUtils extends ChangeNotifier {
  LocalizationUtils._();

  static final instance = LocalizationUtils._();

  Locale? _locale;

  Locale get locale => _locale ?? const Locale('en'); // Default to English if null

  /// Initializes the app's locale based on stored preferences or system locale.
  Future<void> initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? localLanguageCode = prefs.getString('language_code');

    if (localLanguageCode != null) {
      _locale = Locale(localLanguageCode);
    } else {
      // Use system's locale if no saved locale exists
      _locale = Locale(Platform.localeName.split('_')[0]);
    }
    notifyListeners(); // Notify listeners after initialization
  }

  /// Changes the app's locale and stores the locale in SharedPreferences.
  Future<void> changeLocale({required Locale locale, required bool systemDefault}) async {
    const supportedLocales = AppLocalizations.supportedLocales;

    if (systemDefault) {
      _locale = Locale(Platform.localeName.split('_')[0]); // Reset to system default
      await _removeLocaleFromPrefs(); // Clear stored language code
    } else {
      _locale = locale; // Set the new locale
      await _saveLocaleToPrefs(locale); // Save to SharedPreferences
    }

    // Check if the locale is supported
    if (supportedLocales.contains(locale)) {
      _locale = locale;
    } else if (supportedLocales.contains(Locale(locale.languageCode))) {
      _locale = Locale(locale.languageCode);
    } else {
      _locale = const Locale('en'); // Fallback to English
    }

    notifyListeners(); // Notify listeners of locale change
  }

  Future<void> _saveLocaleToPrefs(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
  }

  Future<void> _removeLocaleFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('language_code');
  }

  /// Callback that is invoked when the app's locale is changed.
  Locale? localeResolutionCallback(
      Locale? locale,
      Iterable<Locale> supportedLocales,
      ) {
    if (locale != null && locale.countryCode != null) {
      if (supportedLocales.contains(locale)) {
        return _locale = locale; // Use the provided locale
      } else if (supportedLocales.contains(Locale(locale.languageCode))) {
        return _locale = Locale(locale.languageCode); // Fallback to language only
      }
      return _locale = const Locale('en'); // Fallback to English
    }
    return _locale; // Return the current locale
  }
}
