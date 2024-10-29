import 'package:flutter/material.dart';
import 'package:zpi_project/styles/layouts.dart';
import 'package:zpi_project/widgets/nav_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zpi_project/models/movie_model.dart';
import 'package:zpi_project/widgets/detailed_movie_card/detailed_movie_card_back.dart';
import 'package:zpi_project/widgets/detailed_movie_card/detailed_movie_card_front.dart';
import 'package:zpi_project/widgets/movie_categories_info.dart';
import '../../utils/check_login_status.dart';

class MovieScreen extends StatefulWidget {
  final Movie movie;

  const MovieScreen({super.key, required this.movie});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  bool isFront = true;

  @override
  void initState() {
    super.initState();
    checkLoginStatus(context);
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: MovieScreenContent(
        movie: widget.movie,
        isFront: isFront,
        onCardTapped: () {
          setState(() {
            isFront = !isFront;
          });
        },
      ),
    );
  }
}

class MovieScreenContent extends StatelessWidget {
  final Movie movie;
  final bool isFront;
  final VoidCallback onCardTapped;

  const MovieScreenContent({
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
                      ? DetailedMovieCardFront(
                          key: ValueKey('front'),
                          movie: movie,
                        )
                      : DetailedMovieCardBack(
                          key: ValueKey('back'),
                          movie: movie,
                        ),
                ),
              ),
              const SizedBox(height: 35),
              // MovieCategoriesInfo(
              //   categories: movie.categories,
              // )
            ],
          ),
        ));
  }
}
