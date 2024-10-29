import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../styles/layouts.dart';
import '../../utils/check_login_status.dart';
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

  @override
  void initState() {
    super.initState();
    checkLoginStatus(context);
  }

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
    final localizations = AppLocalizations.of(context);

    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: NavDrawer(),
      appBar: CustomAppBar(text: localizations.connect),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              '${localizations.joined} $roomCode',
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 200),
            Text(
              localizations.friends_in,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            HorizontalLists(friends: friends),
            const Spacer(),
            Text(
              localizations.waiting,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}