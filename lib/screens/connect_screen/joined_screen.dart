import 'package:flutter/material.dart';

class NewScreen extends StatelessWidget {
  final String? roomCode;

  const NewScreen({super.key, required this.roomCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Joined'),
      ),
      body: Center(
        child: Text('Joined room with code: $roomCode'),
      ),
    );
  }
}