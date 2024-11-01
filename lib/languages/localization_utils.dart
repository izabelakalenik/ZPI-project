import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationUtils extends ChangeNotifier {
  LocalizationUtils._();

  static final instance = LocalizationUtils._();

  Locale? _locale;

  Locale get locale => _locale ?? const Locale('en', 'US'); // Default to English (US) if null

  /// Initializes the app's locale based on stored preferences or system locale.
  Future<void> initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString('language_code');
    final String? countryCode = prefs.getString('country_code');

    if (languageCode != null && countryCode != null) {
      // Load stored locale
      _locale = Locale(languageCode, countryCode);
    } else {
      // Use system's locale if no saved locale exists
      final systemLocale = Platform.localeName.split('_');
      _locale = Locale(systemLocale[0], systemLocale.length > 1 ? systemLocale[1] : 'US');
    }
    notifyListeners(); // Notify listeners after initialization
  }

  /// Changes the app's locale and stores the locale in SharedPreferences.
  Future<void> changeLocale({required Locale locale, required bool systemDefault}) async {
    const supportedLocales = AppLocalizations.supportedLocales;

    if (systemDefault) {
      // Reset to system default
      final systemLocale = Platform.localeName.split('_');
      _locale = Locale(systemLocale[0], systemLocale.length > 1 ? systemLocale[1] : 'US');
      await _removeLocaleFromPrefs(); // Clear stored locale
    } else {
      // Set and save the new locale
      _locale = locale;
      await _saveLocaleToPrefs(locale);
    }

    // Check if the locale is supported
    if (!supportedLocales.contains(_locale)) {
      if (supportedLocales.contains(Locale(locale.languageCode))) {
        _locale = Locale(locale.languageCode); // Fallback to language only if country is unsupported
      } else {
        _locale = const Locale('en', 'US'); // Default fallback to English (US)
      }
    }

    notifyListeners(); // Notify listeners of locale change
  }

  Future<void> _saveLocaleToPrefs(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
    await prefs.setString('country_code', locale.countryCode ?? ''); // Save country code if exists
  }

  Future<void> _removeLocaleFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('language_code');
    await prefs.remove('country_code');
  }

  /// Callback that is invoked when the app's locale is changed.
  Locale? localeResolutionCallback(Locale? locale, Iterable<Locale> supportedLocales) {
    if (locale != null) {
      if (supportedLocales.contains(locale)) {
        _locale = locale; // Use the exact match if supported
      } else if (supportedLocales.contains(Locale(locale.languageCode))) {
        _locale = Locale(locale.languageCode); // Fallback to language-only locale
      } else {
        _locale = const Locale('en', 'US'); // Default fallback to English (US)
      }
      return _locale;
    }
    return _locale; // Return the current locale if no locale provided
  }
}
