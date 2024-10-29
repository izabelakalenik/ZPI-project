import 'package:flutter/material.dart';
//import '../../models/movie_model.dart';
import 'package:zpi_project/movies/domain/entities/movie.dart';
import '../../screens/shake_movie_screen.dart';
import '../../styles/layouts.dart';

class RandomMovieButton extends StatelessWidget {
  final List<Movie> movies;

  const RandomMovieButton({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 0),
      child: Center(
        child: Button(
          text: const Text(""),
          icon: Image.asset(
            'assets/dices.png',
            width: 25,
            height: 25,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => ShakeMovieScreen(likedMovies: movies)),
            );
          },
          backgroundColor: Colors.black,
          width: 65,
          height: 65,
        ),
      ),
    );
  }
}
