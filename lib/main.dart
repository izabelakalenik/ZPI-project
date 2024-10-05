import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZPI project',
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),

        fontFamily: 'Sen',

        textTheme: TextTheme(
            displayMedium: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            titleLarge: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            )

        )

      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = MainContent(
          onLoginPressed: _onLoginPressed,
          onRegisterPressed: _onRegisterPressed,
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

class MainContent extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;

  const MainContent({
    super.key,
    required this.onLoginPressed,
    required this.onRegisterPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE7C039), Color(0xFFA80092)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
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
      ),
    );
  }
}



class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Login Page',
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Register Page',
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
