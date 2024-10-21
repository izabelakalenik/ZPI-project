import 'package:flutter/material.dart';
import '../../styles/layouts.dart';
import '../../widgets/nav_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/qr_code_scanner.dart';
import 'joined_screen.dart';

class JoinerScreen extends StatefulWidget {
  const JoinerScreen({super.key});

  @override
  State<JoinerScreen> createState() => _JoinerScreenState();
}

class _JoinerScreenState extends State<JoinerScreen> {

  late TextEditingController _roomController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
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
            setState(() {
              _roomController.text = code;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: JoinerScreenContent(
        roomController: _roomController,

        onConnectPressed: () {
          String roomCode = _roomController.text;
          if (roomCode.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JoinedScreen(roomCode: roomCode),
              ),
            );
          }
          else {
            //error handling
          }
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
        drawer: NavDrawer(),
        appBar: CustomAppBar(text: "Connect"),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'To Join A Room',
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              Button(
                width: 200,
                onPressed: onQrPressed,
                text: Text('Scan QR Code'),
              ),
              SizedBox(height: 30),
              Text(localizations.or,
                  style: theme.textTheme.bodyLarge),
              SizedBox(height: 30),
              CustomTextField(
                labelText: "Room Code",
                controller: roomController,
              ),
              SizedBox(height: 50),
              Button(
                width: 200,
                onPressed: onConnectPressed,
                text: Text('Connect'),
              ),
            ],
          ),
        ),
      );
  }
}
