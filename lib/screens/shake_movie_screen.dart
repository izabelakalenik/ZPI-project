import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shake_detector/shake_detector.dart';
import 'package:zpi_project/styles/layouts.dart';
import 'package:zpi_project/widgets/movie_card/movie_card_model.dart';

class ShakeMovieScreen extends StatefulWidget {
  final List<MovieCardModel> likedMovies;

  const ShakeMovieScreen({super.key, required this.likedMovies});

  @override
  State<StatefulWidget> createState() => _ShakeMovieScreenState();
}

class _ShakeMovieScreenState extends State<ShakeMovieScreen> {
  late List<MovieCardModel> likedMovies;
  late MovieCardModel selectedMovie;

  void selectRandomMovie(List<MovieCardModel> likedMovies) {
    final random = Random();
    final randomMovie = likedMovies[random.nextInt(likedMovies.length)];

    setState(() {
      selectedMovie = randomMovie;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieScreen(movie: selectedMovie),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    likedMovies = widget.likedMovies;
    return MainLayout(
      child: Scaffold(
        appBar: CustomAppBar(text: localizations.shake_movie_screen_title),
        body: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start, // Start aligning from the top
              children: [
                SizedBox(height: 200), // Adjust this value to position the image higher
                Center(
                  child: ShakeDetectWrap(
                    onShake: () {
                      selectRandomMovie(likedMovies);
                    },
                    child: Opacity(
                      opacity: 0.3,
                      child: Image.asset(
                        "assets/shake.png",
                        fit: BoxFit.cover,
                        height: 250, // Height of the image
                        width: 250,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 80, // Adjust as needed
              left: 0,
              right: 0,
              child: Column(
                children: <Widget>[
                  Text(
                    'Shake your phone to select a random movie!',
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Button(
                    text: Text("shake"),
                    onPressed: () {
                      selectRandomMovie(likedMovies);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieScreen extends StatelessWidget {
  final MovieCardModel movie;

  const MovieScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MainLayout(
        child: Scaffold(
            appBar: CustomAppBar(text: "Your movie"),
            body: Center(
                child: Text(
              movie.title,
              style: theme.textTheme.displayMedium,
            ))));
  }
}
