import 'package:flutter/material.dart';
//import 'package:zpi_project/models/movie_model.dart';
import 'package:zpi_project/movies/domain/entities/movie.dart';

class DetailedMovieCardFront extends StatelessWidget {
  final Movie movie;

  const DetailedMovieCardFront({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 370,
      height: 535,
      child: Card(
        color: Colors.white.withOpacity(0.25),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  movie.title,
                  style: theme.textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Stack(
                  children: [
                    Image.network(
                      movie.posterPath,
                      height: 400,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.info_outline),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
