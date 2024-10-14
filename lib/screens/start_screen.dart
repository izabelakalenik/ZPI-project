import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  @override
  Widget build(BuildContext context) {
    return MainLayout(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StartScreenContent(
            onLoginPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => LoginBloc(),
                    child: const LoginScreen(),
                  ),
                ),
              );
            },
            onRegisterPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterPage(),
                ),
              );
            },
          ),
        ));
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
    final localizations = AppLocalizations.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          localizations.appTitle,
          style: theme.textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          localizations.welcomeMessage,
          style: theme.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 100),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Button(
              text: Text(localizations.login_1),
              onPressed: onLoginPressed,
            ),
            const SizedBox(width: 30),
            Button(
              text: Text(
                localizations.register,
                textAlign: TextAlign.center,
              ),
              onPressed: onRegisterPressed,
            ),
          ],
        ),
      ],
    );
  }
}
