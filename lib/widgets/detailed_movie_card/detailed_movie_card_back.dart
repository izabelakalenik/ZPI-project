import 'package:flutter/material.dart';
import 'package:zpi_project/models/movie_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailedMovieCardBack extends StatelessWidget {
  final Movie movie;

  const DetailedMovieCardBack({super.key, required this.movie});

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 400,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(movie.overview,
                            style: theme.textTheme.titleLarge,
                            textAlign: TextAlign.center),
                        SizedBox(height: 10),
                        Text(AppLocalizations.of(context).rating,
                            style: theme.textTheme.headlineSmall),
                        Text(movie.voteAverage.toString(),
                            style: theme.textTheme.titleLarge),
                        Text(AppLocalizations.of(context).release_date,
                            style: theme.textTheme.headlineSmall),
                        Text(movie.releaseDate,
                            style: theme.textTheme.titleLarge),
                        Text(AppLocalizations.of(context).is_for_adults,
                            style: theme.textTheme.headlineSmall),
                        Text(
                          movie.isForAdults
                              ? AppLocalizations.of(context).yes
                              : AppLocalizations.of(context).no,
                          style: theme.textTheme.titleLarge,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
