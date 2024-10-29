import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../movies/domain/entities/movie.dart';

class ModalBottomSheet extends StatelessWidget {
  final Movie movie;

  const ModalBottomSheet({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.black.withOpacity(0.95),
      height: screenHeight * 0.88,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 65,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                movie.title,
                style: theme.textTheme.headlineLarge,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      movie.posterPath,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child:
                        Text(movie.overview, style: theme.textTheme.titleLarge),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    localizations.rating,
                    style: theme.textTheme.headlineSmall,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    movie.voteAverage.toString(),
                    style: theme.textTheme.titleLarge,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    localizations.release_date,
                    style: theme.textTheme.headlineSmall,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    movie.releaseDate,
                    style: theme.textTheme.titleLarge,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    localizations.is_for_adults,
                    style: theme.textTheme.headlineSmall,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    movie.isForAdults ? localizations.yes : localizations.no,
                    style: theme.textTheme.titleLarge,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent
              ),
              onPressed: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_downward,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
