import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PopupWindow extends StatelessWidget {

  const PopupWindow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: const Color(0xFFFFC8DD).withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              localizations.logout,
              style: theme.textTheme.displayMedium?.copyWith(
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: const Offset(1.0, 2.0),
                    blurRadius: 3.0,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              localizations.logout_text,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}