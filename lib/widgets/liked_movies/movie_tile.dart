import 'package:flutter/material.dart';
//import '../../models/movie_model.dart';
import 'package:zpi_project/movies/domain/entities/movie.dart';
import '../../screens/movie_screen.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;

  const MovieTile({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        // Navigator.of(context).pop(),
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieScreen(movie: movie)),
        ),
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white.withOpacity(0.2),
        shadowColor: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15), bottom: Radius.circular(15)),
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: Image.network(
                    movie.posterPath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
