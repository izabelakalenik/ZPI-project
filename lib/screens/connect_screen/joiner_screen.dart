import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:zpi_project/utils/check_login_status.dart';
import '../../styles/layouts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/qr_code_scanner.dart';
import 'join_room_dialog.dart';
import 'package:firebase_database/firebase_database.dart';


class JoinerScreen extends StatefulWidget {
  const JoinerScreen({super.key});

  @override
  State<JoinerScreen> createState() => _JoinerScreenState();
}

class _JoinerScreenState extends State<JoinerScreen> {
  late TextEditingController _roomController;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    checkLoginStatus(context);
  }

  void _initializeControllers() {
    _roomController = TextEditingController();
  }

  @override
  void dispose() {
    _roomController.dispose();
    super.dispose();
  }

  void _navigateToQRScanner(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QrCodeScanner(
          onCodeScanned: (code) {
            if(_isValidRoomCode(code)) {
              Navigator.pop(context);
              showJoinRoomDialog(context, code);
              setState(() {
                _roomController.text = code;
              });
            }
          },
        ),
      ),
    );
  }

  Future<void> _validateAndShowDialog(BuildContext context, String roomCode) async {
    final localizations = AppLocalizations.of(context);
    final roomRef = _database.child('rooms').child(roomCode);
    final roomSnapshot = await roomRef.get();

    if (roomSnapshot.exists && _isValidRoomCode(roomCode)) {
      showJoinRoomDialog(context, roomCode);
    } else if (!_isValidRoomCode(roomCode)){
      _showErrorDialog(context, localizations.error_room);
    }
    else {
      _showErrorDialog(context, 'Room does not exist');
    }
  }

  bool _isValidRoomCode(String roomCode) {
    if (roomCode.length != 8) return false;
    if (roomCode.contains('http') || roomCode.contains('https')) return false;
    return true;
  }

  void _showErrorDialog(BuildContext context, String message) {
    final localizations = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            localizations.error,
            style: const TextStyle(color: Color(0xFFC3584B)),
          ),
          content: Text(
            message,
            style: const TextStyle(color: Color(0xFF25011F)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                  localizations.ok,
                style: TextStyle(color: Color(0xFFC3584B)),
              ),
            ),
          ],
        );
      },
    );
  }

  void showJoinRoomDialog(BuildContext context, String roomCode) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: JoinRoomDialog(roomCode: roomCode),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: JoinerScreenContent(
        roomController: _roomController,
        onConnectPressed: () {
          String roomCode = _roomController.text;
          _validateAndShowDialog(context, roomCode);
        },
        onQrPressed: () => _navigateToQRScanner(context)
      ),
    );
  }
}

class JoinerScreenContent extends StatelessWidget {
  final VoidCallback onConnectPressed;
  final TextEditingController roomController;
  final VoidCallback onQrPressed;

  const JoinerScreenContent({
    super.key,
    required this.roomController,
    required this.onConnectPressed,
    required this.onQrPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

    return
      Scaffold(
        appBar: CustomAppBar(text: localizations.connect),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                localizations.to_join,
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              Button(
                width: 230,
                onPressed: onQrPressed,
                text: Text(localizations.scan),
              ),
              SizedBox(height: 30),
              Text(localizations.or,
                  style: theme.textTheme.bodyLarge),
              SizedBox(height: 30),
              CustomTextField(
                labelText: localizations.room_code,
                controller: roomController,
              ),
              SizedBox(height: 50),
              Button(
                width: 230,
                onPressed: onConnectPressed,
                text: Text(localizations.connect),
              ),
            ],
          ),
        ),
      );
  }
}
