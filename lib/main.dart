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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange.shade200),
        ),
        home: MyHomePage(),
      );
  }
}

class MyHomePage extends StatefulWidget {
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
        /// TO DO
        // page = LoginPage();
        break;
      case 1:
      /// TO DO
        // page = RegisterPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: MainContent(),
        )
      )
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    /// I NEED TO THINK HOW TO CONNECT CLICKING BUTTONS TO THIS WIDGET MENU IN _MyHomePageState (selectedIndex)
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
                'Swipe to find movies you and your friends both want to watch. Let’s make a movie match!',
                style: style,
                textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height:200),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  ///TO DO
                  // move to the next screen
                },
                child: Text('Log in'),
              ),
              SizedBox(width: 30),
              ElevatedButton(
                onPressed: () {
                  ///TO DO
                  // move to the next screen
                },
                child: Text('Register'),
              ),
            ],
          ),
        ]
    );
  }
}