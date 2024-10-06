import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zpi_project/screens/register_screen.dart';

import '../styles/layouts.dart';
import 'login_screen/login_bloc.dart';
import 'login_screen/login_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;

    switch (selectedIndex) {
      case 0:
        page = MainLayout(
          child: StartScreenContent(
            onLoginPressed: _onLoginPressed,
            onRegisterPressed: _onRegisterPressed,
          ),
        );
        break;
      case 1:
        page = BlocProvider(
          create: (context) => LoginBloc(),
          child: MainLayout(
            child: const LoginScreen(),
          ),
        );
        break;
      case 2:
        page = const RegisterPage();
        break;
      default:
        throw UnimplementedError('No widget for $selectedIndex');
    }
    return page;
  }

  void _onLoginPressed() {
    setState(() {
      selectedIndex = 1;
    });
  }

  void _onRegisterPressed() {
    setState(() {
      selectedIndex = 2;
    });
  }
}

class StartScreenContent extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;

  const StartScreenContent({
    super.key,
    required this.onLoginPressed,
    required this.onRegisterPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'MoviePop',
          style: theme.textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          'Swipe to find movies you and your friends both want to watch. Let’s make a movie match!',
          style: theme.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 100),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Button(
              text: const Text('Log in'),
              onPressed: onLoginPressed,
            ),
            const SizedBox(width: 30),
            Button(
              text: const Text('Register'),
              onPressed: onRegisterPressed,
            ),
          ],
        ),
      ],
    );
  }
}
