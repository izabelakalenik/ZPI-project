import 'package:flutter/material.dart';
import '../styles/layouts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(child: HomeScreenContent());
  }
}

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  void someAction() {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MoviePop',
          style: theme.textTheme.displayMedium,
        ),
        actions: <Widget>[
          /// TO DO: POPUP MENU BUTTON
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Categories',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Button(
                  text: Text(
                    'Comedy',
                    style: theme.textTheme.titleSmall,
                  ),
                  onPressed: someAction,
                ),
                Button(
                  text: Text(
                    'Romance',
                    style: theme.textTheme.titleSmall,
                  ),
                  onPressed: someAction,
                ),
                Button(
                  text: Text(
                    'Crime',
                    style: theme.textTheme.titleSmall,
                  ),
                  onPressed: someAction,
                ),
                Button(
                  text: Text(
                    'Documentary',
                    style: theme.textTheme.titleSmall,
                  ),
                  onPressed: someAction,
                ),
                Button(
                  text: Text(
                    'Drama',
                    style: theme.textTheme.titleSmall,
                  ),
                  onPressed: someAction,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 4,
            child: SizedBox(
              width: 300,
              height: 400,
              child: Text(
                'PHOTO',
                style: theme.textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button(
                text: const Text('X'),
                onPressed: someAction,
              ),
              const SizedBox(width: 30),
              Button(
                text: const Text('<3'),
                onPressed: someAction,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
