import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shake_detector/shake_detector.dart';
import 'package:zpi_project/styles/layouts.dart';
import '../models/movie_model.dart';

class ShakeMovieScreen extends StatefulWidget {
  final List<Movie> likedMovies;

  const ShakeMovieScreen({super.key, required this.likedMovies});

  @override
  State<StatefulWidget> createState() => _ShakeMovieScreenState();
}

class _ShakeMovieScreenState extends State<ShakeMovieScreen> {
  void _selectRandomMovie(List<Movie> movies) {
    final random = Random();
    final randomMovie = movies[random.nextInt(movies.length)];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieScreen(movie: randomMovie),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final likedMovies = widget.likedMovies;

    return MainLayout(
      child: Scaffold(
        appBar: CustomAppBar(text: localizations.shake_movie_screen_title),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: <Widget>[
              _buildImageSection(likedMovies),
              _buildBottomSection(likedMovies),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(List<Movie> likedMovies) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 200),
        Center(
          child: ShakeDetectWrap(
            onShake: () => _selectRandomMovie(likedMovies),
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                "assets/shake.png",
                fit: BoxFit.cover,
                height: 250,
                width: 250,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSection(List<Movie> likedMovies) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

    return Positioned(
      bottom: 80,
      left: 0,
      right: 0,
      child: Column(
        children: <Widget>[
          Text(
            localizations.shake_movie_screen_description,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          CustomButton(
            onPressed: () => _selectRandomMovie(likedMovies),
            text: Text(localizations.shake_movie_screen_button),
          ),
        ],
      ),
    );
  }
}

// Simplified version of the Movie Screen
class MovieScreen extends StatelessWidget {
  final Movie movie;

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
          ),
        ),
      ),
    );
  }
}
