import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zpi_project/screens/connect_screen/joined/joined_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../styles/layouts.dart';
import '../../widgets/dialog.dart';
import 'joined/joined_bloc.dart';

class JoinRoomDialog extends StatefulWidget {
  final String roomCode;

  const JoinRoomDialog({super.key, required this.roomCode});

  @override
  State<JoinRoomDialog> createState() => _JoinRoomDialogState();
}

class _JoinRoomDialogState extends State<JoinRoomDialog> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  void _joinRoom(String roomCode) async {
    final user = FirebaseAuth.instance.currentUser;

    final roomRef = _database.child('rooms').child(roomCode);
    final participantsRef = roomRef.child('participants');
    participantsRef.child('userId123').set('UserName');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => JoinedBloc(),
          child: JoinedScreen(roomCode: roomCode),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return PopupWindow(
      text: localizations.join,
      child: Column(
        children: [
          Text(
            '${localizations.are_you_sure_room}${widget.roomCode}?',
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PopupButton(
                onPressed: () {
                  _joinRoom(widget.roomCode);
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
