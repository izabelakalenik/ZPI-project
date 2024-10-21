import 'package:flutter/material.dart';
import 'package:zpi_project/screens/connect_screen/joined_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../styles/layouts.dart';
import '../../widgets/dialog.dart';

class JoinRoomDialog extends StatefulWidget {
  final String roomCode;

  const JoinRoomDialog({super.key, required this.roomCode});

  @override
  State<JoinRoomDialog> createState() => _JoinRoomDialogState();
}

class _JoinRoomDialogState extends State<JoinRoomDialog> {

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return PopupWindow(
      text: 'Join Room',
      child: Column(
        children: [
          Text(
            'Are you sure you want to join the room with code: ${widget.roomCode}?',
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PopupButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JoinedScreen(roomCode: widget.roomCode),
                    ),
                  );
                },
                text: localizations.yes,
              ),
              const SizedBox(width: 30),
              PopupButton(
                onPressed: () => Navigator.pop(context),
                text: localizations.no,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
