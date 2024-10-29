import 'package:flutter/material.dart';
import 'package:zpi_project/styles/layouts.dart';
import 'package:zpi_project/widgets/nav_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zpi_project/models/movie_model.dart';
import 'package:zpi_project/widgets/movie_categories_info.dart';
import '../../utils/check_login_status.dart';
import 'package:zpi_project/widgets/movie_card/movie_card.dart';

class MovieScreen extends StatefulWidget {
  final Movie movie;

  const MovieScreen({super.key, required this.movie});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {

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
        onCardTapped: () {}
      ),
    );
  }
}

class MovieScreenContent extends StatelessWidget {
  final Movie movie;
  final VoidCallback onCardTapped;

  const MovieScreenContent({
    super.key,
    required this.movie,
    required this.onCardTapped,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

    return Scaffold(
        drawer: NavDrawer(),
        appBar: CustomAppBar(text: localizations.likedMovies),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // GestureDetector(
              //   onTap: onCardTapped,
              //   child: AnimatedSwitcher(
              //     duration: const Duration(milliseconds: 0),
              //     child: MovieCard(
              //             key: ValueKey('front'),
              //             movie: movie,
              //           )
              //   ),
              // ),
              MovieCard(movie: movie),
              // MovieCategoriesInfo(
              //   categories: movie.categories,
              // )
            ],
          ),
        ));
  }
}
