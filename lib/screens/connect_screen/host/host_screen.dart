import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:zpi_project/utils/check_login_status.dart';
import 'package:zpi_project/utils/screen_brightness_manager.dart';
import '../../../styles/layouts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'host_bloc.dart';

class HostScreen extends StatefulWidget {
  const HostScreen({super.key});

  @override
  State<HostScreen> createState() => _HostScreenState();
}

class _HostScreenState extends State<HostScreen> {

  late TextEditingController _roomController;
  final ScreenBrightnessManager _brightnessManager = ScreenBrightnessManager(); // Instance of ScreenBrightnessManager

  @override
  void initState() {
    super.initState();
    checkLoginStatus(context);
    context.read<HostBloc>().add(CreateRoom());
    _initializeControllers();
    _increaseBrightness();

  }


  void _initializeControllers() {
    _roomController = TextEditingController();
  }

  @override
  void dispose() {
    _roomController.dispose();
    _restoreBrightness();
    super.dispose();
  }

  // Call the manager to increase brightness
  Future<void> _increaseBrightness() async {
    await _brightnessManager.increaseBrightness();
  }

  // Call the manager to restore brightness
  Future<void> _restoreBrightness() async {
    await _brightnessManager.restoreBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HostBloc, HostState>(
      builder: (context, state) {
        List<String> friends = [];

        if (state is HostRoomCreated) {
          _roomController.text = state.roomCode;
        } else if (state is HostParticipantsUpdated) {
          friends = state.friends;
        }

        return MainLayout(
          child: HostScreenContent(
            roomCode: _roomController.text,
            friends: friends,
            roomController: _roomController,
            onConnectPressed: () {
              // Action when Connect button is pressed
            },
          ),
        );
      },
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
    final localizations = AppLocalizations.of(context);

    return
      Scaffold(
          appBar: CustomAppBar(text: localizations.connect),
          body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text(
                localizations.your_qr,
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
                localizations.your_room,
                style: theme.textTheme.bodyLarge,
              ),
              SizedBox(height: 10),
              CustomTextField(
                readOnly: true,
                labelText: localizations.room_code,
                controller: roomController,
              ),
              SizedBox(height: 30),
              // Friends Section
              Text(
                localizations.joined_friends,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 10),
              HorizontalLists(friends: friends),
              SizedBox(height: 50),
              // Connect Button
              Button(
                onPressed: onConnectPressed,
                text: Text(localizations.connect),
              ),
            ],
          ),
        ),
      );
  }
}
