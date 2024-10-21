import 'package:flutter/material.dart';

import '../../styles/layouts.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Joined room with code: $roomCode',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
        const Text(
          'Friends in the room:',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: friends
              .map(
                (friend) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Text(
                  friend,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}