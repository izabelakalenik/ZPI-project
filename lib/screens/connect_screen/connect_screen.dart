import 'package:flutter/material.dart';
import 'package:zpi_project/screens/connect_screen/host_screen.dart';
import 'package:zpi_project/screens/connect_screen/joiner_screen.dart';

import '../../styles/layouts.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
        ));
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
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Text(
          "Connect",
          style: theme.textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 130),
        Text(
          "Let's Find Movies You All Want To Watch!",
          style: theme.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 70),
        Column(
          children: [
            Button(
              text: Text('Create a room', textAlign: TextAlign.center),
              onPressed: onCreateRoomPressed,
              width: 200,
            ),
            const SizedBox(height: 30),
            Text('Or', style: theme.textTheme.bodyLarge),
            const SizedBox(height: 30),
            Button(
              text: Text('Join a room', textAlign: TextAlign.center),
              onPressed: onJoinRoomPressed,
              width: 200,
            ),
          ],
        ),
      ],
    ),
    );
  }
}
