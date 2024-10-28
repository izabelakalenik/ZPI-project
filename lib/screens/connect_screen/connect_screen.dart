import 'package:flutter/material.dart';
import 'package:zpi_project/screens/connect_screen/host_screen.dart';
import 'package:zpi_project/screens/connect_screen/joiner_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../styles/layouts.dart';
import '../../utils/check_login_status.dart';
import '../../widgets/nav_drawer.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {

  @override
  void initState() {
    super.initState();
    checkLoginStatus(context);
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: ConnectScreenContent(
        onCreateRoomPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HostScreen()),
          );
        },
        onJoinRoomPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JoinerScreen()),
          );
        },
      ),
    );
  }
}

class ConnectScreenContent extends StatelessWidget {
  final VoidCallback onCreateRoomPressed;
  final VoidCallback onJoinRoomPressed;

  const ConnectScreenContent({
    super.key,
    required this.onCreateRoomPressed,
    required this.onJoinRoomPressed,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
        drawer: NavDrawer(),
        appBar: CustomAppBar(text: localizations.connect),
        body:  Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 140),
              Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child:
                  Text(
                    localizations.lets,
                    style: theme.textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(height: 100),
              Column(
                children: [
                  Button(
                    text: Text(localizations.create_room, textAlign: TextAlign.center),
                    onPressed: onCreateRoomPressed,
                    width: 230,
                  ),
                  const SizedBox(height: 30),
                  Text(localizations.or, style: theme.textTheme.bodyLarge),
                  const SizedBox(height: 30),
                  Button(
                    text: Text(localizations.join, textAlign: TextAlign.center),
                    onPressed: onJoinRoomPressed,
                    width: 230,
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}

