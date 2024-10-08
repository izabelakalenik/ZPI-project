import 'package:flutter/material.dart';
import 'movie_card_model.dart';

class MovieCard extends StatelessWidget {
  final MovieCardModel movie;

  const MovieCard(
    this.movie, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Image.asset(
              movie.poster,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 330,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: theme.textTheme.labelLarge,
                ),
                const SizedBox(height: 3),
                Text(
                  movie.director,
                  style: theme.textTheme.labelMedium,
                ),
                const SizedBox(height: 5),
                Text(
                  movie.description,
                  style: theme.textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
