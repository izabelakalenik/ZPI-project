import 'package:flutter/material.dart';
import 'package:zpi_project/styles/layouts.dart';
import 'package:zpi_project/widgets/nav_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zpi_project/movies/domain/entities/movie.dart';
import 'package:zpi_project/widgets/movie_card/movie_categories_info.dart';
import '../utils/check_login_status.dart';
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
          onPressed: () {}
      ),
    );
  }
}

class MovieScreenContent extends StatelessWidget {
  final Movie movie;
  final VoidCallback onPressed;

  const MovieScreenContent({
    super.key,
    required this.movie,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
        drawer: NavDrawer(),
        appBar: CustomAppBar(text: localizations.likedMovies),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MovieCard(movie: movie),
              const SizedBox(height: 10),
              MovieCategoriesInfo(
                categories: movie.categories,
              )
            ],
          ),
        ));
  }


}
