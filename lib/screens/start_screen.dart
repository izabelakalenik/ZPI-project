import 'package:flutter/material.dart';
import 'package:zpi_project/screens/register_screen.dart';
import 'login_screen.dart';
import '../main_layout.dart';

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
        page = MainLayout(child: StartScreenContent(
          onLoginPressed: _onLoginPressed,
          onRegisterPressed: _onRegisterPressed,
          ),
        );
        break;
      case 1:
        page = const LoginPage();
        break;
      case 2:
        page = const RegisterPage();
        break;
      default:
        throw UnimplementedError('No widget for $selectedIndex');
    }

    return Scaffold(
      body: SafeArea(
          child: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: page,
          )
      ),
    );
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


    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // Nagłówek "Match Flix"
          Text(
            'Match Flix',
            style: theme.textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Opis aplikacji
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Swipe to find movies you and your friends both want to watch. Let’s make a movie match!',
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 100),

          // Przyciski Log in i Register
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 150,
                height: 50,
                child: OutlinedButton(
                  onPressed: onLoginPressed,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white, width: 1.5),
                    foregroundColor: Colors.white,
                    textStyle: theme.textTheme.titleLarge,
                  ),
                  child: const Text('Log in'),
                ),
              ),
              const SizedBox(width: 30),
              SizedBox(
                width: 150,
                height: 50,
                child: OutlinedButton(
                  onPressed: onRegisterPressed,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white, width: 1.5),
                    foregroundColor: Colors.white,
                    textStyle: theme.textTheme.titleLarge,
                  ),
                  child: const Text('Register'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
