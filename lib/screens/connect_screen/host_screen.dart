import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../styles/layouts.dart';
import '../../widgets/nav_drawer.dart';

class HostScreen extends StatefulWidget {
  const HostScreen({super.key});

  @override
  State<HostScreen> createState() => _HostScreenState();
}

class _HostScreenState extends State<HostScreen> {
  String roomCode = '';
  List<String> friends = [];
  late TextEditingController _roomController;

  @override
  void initState() {
    super.initState();
    // Generate a unique room code
    roomCode = Uuid().v4().substring(0, 12);
    _initializeControllers();
  }

  // Function to simulate adding friends when they join by entering the code
  void addFriend(String friendName) {
    setState(() {
      friends.add(friendName);
    });
  }

  void _initializeControllers() {
    _roomController = TextEditingController(text: roomCode);
  }

  @override
  void dispose() {
    _roomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: HostScreenContent(
        roomCode: roomCode,
        friends: friends,
        roomController: _roomController,
        onConnectPressed: () {
          // Action when Connect button is pressed
        },
      ),
    );
  }
}

class HostScreenContent extends StatelessWidget {
  final String roomCode;
  final List<String> friends;
  final VoidCallback onConnectPressed;
  final TextEditingController roomController;

  const HostScreenContent({
    super.key,
    required this.roomCode,
    required this.friends,
    required this.roomController,
    required this.onConnectPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return
      Scaffold(
        drawer: NavDrawer(),
        appBar: CustomAppBar(text: "Connect"),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text(
                'Your QR Code',
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // QR Code with rounded corners
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: QrImageView(
                      data: roomCode,
                      size: 200,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Room Code Display
              Text(
                'Your Room Code',
                style: theme.textTheme.bodyLarge,
              ),
              SizedBox(height: 10),
              CustomTextField(
                readOnly: true,
                labelText: "Room Code",
                controller: roomController,
              ),
              SizedBox(height: 30),
              // Friends Section
              Text(
                'Joined Friends',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 10),
              HorizontalLists(friends: friends),
              SizedBox(height: 50),
              // Connect Button
              Button(
                onPressed: onConnectPressed,
                text: Text('Connect'),
              ),
            ],
          ),
        ),
      );
  }
}
