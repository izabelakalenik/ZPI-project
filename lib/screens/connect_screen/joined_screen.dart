import 'package:flutter/material.dart';

import '../../styles/layouts.dart';
import '../../widgets/nav_drawer.dart';

class JoinedScreen extends StatefulWidget {
  final String? roomCode;

  const JoinedScreen({
    super.key,
    required this.roomCode,
  });

  @override
  State<JoinedScreen> createState() => JoinedScreenState();
}

class JoinedScreenState extends State<JoinedScreen> {
  final List<String> friends = [];
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: JoinedScreenContent(
        roomCode: widget.roomCode,
        friends: friends,
      ),
    );
  }
}

class JoinedScreenContent extends StatelessWidget {
  final String? roomCode;
  final List<String> friends;

  const JoinedScreenContent({
    required this.roomCode,
    required this.friends,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: NavDrawer(),
      appBar: CustomAppBar(text: "Connect"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Joined a room with code: $roomCode',
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 200),
            Text(
              'Friends in the room:',
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            HorizontalLists(friends: friends),
            const Spacer(),
            Text(
              'Waiting for the host to start session...',
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}