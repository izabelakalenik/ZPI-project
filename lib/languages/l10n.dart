import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Global navigator key to get access to the BuildContext globally.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Extension function to get [l10n] object from [BuildContext].
extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

/// Global [l10n] object that is used when [BuildContext] is not available.
AppLocalizations? get l10n => AppLocalizations.of(navigatorKey.currentContext!);
