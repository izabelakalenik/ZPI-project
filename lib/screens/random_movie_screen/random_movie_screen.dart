import 'package:flutter/material.dart';
import 'package:zpi_project/styles/layouts.dart';
import 'package:zpi_project/widgets/nav_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zpi_project/models/movie_model.dart';
import 'package:zpi_project/widgets/random_movie_card/random_movie_card_back.dart';
import 'package:zpi_project/widgets/random_movie_card/random_movie_card_front.dart';
import 'package:zpi_project/widgets/movie_categories_info.dart';

class RandomMovieScreen extends StatefulWidget {
  const RandomMovieScreen({super.key});

  @override
  State<RandomMovieScreen> createState() => _RandomMovieScreenState();
}

class _RandomMovieScreenState extends State<RandomMovieScreen> {
  bool isFront = true;

  final movie = Movie(
    id: 533535,
    title: 'Deadpool & Wolverine',
    overview:
        'Dochodzacy do siebie Wolverine spotyka pyskatego Deadpoola, z którym łączy siły, by stawić czoła wspólnemu wrogowi.Deadpool to sarkastyczny antybohater, który po eksperymentalnym leczeniu zyskuje zdolności regeneracyjne. Uzbrojony w cięty humor i niezwykłe moce, wyrusza na misję zemsty, nie oszczędzając nikogo po drodze.',
    posterPath:
        'https://image.tmdb.org/t/p/w500//7Hi6mRLsQtTaEtKiHqSeRFR1TQ2.jpg',
    voteAverage: 7.722,
    releaseDate: "2024-07-26",
    isForAdults: false,
    categories: ['Action', 'Comedy', 'Documentary'],
  );

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: RandomMovieScreenContent(
          movie: movie,
          isFront: isFront,
          onCardTapped: () {
            setState(() {
              isFront = !isFront;
            });
          }),
    );
  }
}

class RandomMovieScreenContent extends StatelessWidget {
  final Movie movie;
  final bool isFront;
  final VoidCallback onCardTapped;

  const RandomMovieScreenContent({
    super.key,
    required this.movie,
    required this.isFront,
    required this.onCardTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: CustomAppBar(text: AppLocalizations.of(context).likedMovies),
        body: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: onCardTapped,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 0),
                  child: isFront
                      ? RandomMovieCardFront(
                          key: ValueKey('front'),
                          movie: movie,
                        )
                      : RandomMovieCardBack(
                          key: ValueKey('back'),
                          movie: movie,
                        ),
                ),
              ),
              const SizedBox(height: 35),
              MovieCategoriesInfo(
                categories: movie.categories,
              )
            ],
          ),
        ));
  }
}
