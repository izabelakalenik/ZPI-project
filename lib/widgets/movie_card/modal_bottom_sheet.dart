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

    // Convert rating to a 5-star scale
    double starRating = movie.voteAverage / 2;

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        color: Color(0xFF160012).withOpacity(0.9),
        height: screenHeight * 0.88,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 60,
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          movie.posterPath,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: Text(
                        movie.overview,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      localizations.rating,
                      style: theme.textTheme.labelLarge,
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        double fillAmount = (starRating - index).clamp(0.0, 1.0);
                        return Stack(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white.withOpacity(0.3), // Empty star background
                            ),
                            ClipRect(
                              clipper: _StarClipper(fillAmount),
                              child: Icon(
                                Icons.star,
                                color: Colors.white, // Filled portion of the star
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      localizations.release_date,
                      style: theme.textTheme.labelLarge,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      movie.releaseDate,
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      localizations.age_recommendation,
                      style: theme.textTheme.labelLarge,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        // Display 18+ or 13+ icon based on `isForAdults`
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2), // White border
                          ),
                          child: Text(
                            movie.isForAdults ? '18+' : '13+',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white, // White text
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide.none,
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
      ),
    );
  }
}

class _StarClipper extends CustomClipper<Rect> {
  final double fillPercent;

  _StarClipper(this.fillPercent);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width * fillPercent, size.height);
  }

  @override
  bool shouldReclip(_StarClipper oldClipper) {
    return oldClipper.fillPercent != fillPercent;
  }
}
