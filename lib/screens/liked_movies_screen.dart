import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import '../models/movie_model.dart';
import 'package:zpi_project/movies/domain/entities/movie.dart';
import '../database_configuration/firestore_service.dart';
import '../movies/data/data_sources/movie_remote_data_source.dart';
import '../movies/data/repositories/movie_repository_impl.dart';
import '../styles/layouts.dart';
import '../utils/check_login_status.dart';
import '../widgets/category_selector.dart';
import '../widgets/liked_movies/movie_grid.dart';
import '../widgets/liked_movies/random_movie_button.dart';
import '../widgets/nav_drawer.dart';

class LikedMoviesScreen extends StatefulWidget {
  const LikedMoviesScreen({super.key});

  @override
  State<LikedMoviesScreen> createState() => _LikedMoviesScreenState();
}

class _LikedMoviesScreenState extends State<LikedMoviesScreen> {
  List<Movie> _likedMovies = [];
  List<String> _selectedCategories = [];

  @override
  void initState() {
    super.initState();
    checkLoginStatus(context);
    _fetchLikedMovies();
  }

  Future<void> _fetchLikedMovies() async {
    final userLikedMovieIds = await FirestoreService().getLikedMovies();
    final likedMovies = await MovieRepositoryImpl(MovieRemoteDataSource())
        .fetchLikedMovies(userLikedMovieIds);
    setState(() {
      _likedMovies = likedMovies;
    });
  }

  List<Movie> get _filteredMovies {
    if (_selectedCategories.isEmpty) return _likedMovies;
    return _likedMovies.where((movie) {
      return movie.categories
          .any((category) => _selectedCategories.contains(category));
    }).toList();
  }

  void _onCategoriesSelected(List<String> selectedCategories) {
    setState(() {
      _selectedCategories = selectedCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: LikedMoviesScreenContent(
        movies: _filteredMovies,
        onCategoriesSelected: _onCategoriesSelected,
      ),
    );
  }
}

class LikedMoviesScreenContent extends StatelessWidget {
  final List<Movie> movies;
  final Function(List<String>) onCategoriesSelected;

  const LikedMoviesScreenContent({
    super.key,
    required this.movies,
    required this.onCategoriesSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      drawer: NavDrawer(),
      appBar: CustomAppBar(text: localizations.liked_movies_title),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.categories,
              style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 20),
            CategorySelector(
              categories: [
                localizations.romance,
                localizations.documentary,
                localizations.fantasy,
                localizations.scifi,
              ],
              onCategorySelected: onCategoriesSelected,
            ),
            const SizedBox(height: 20),
            MovieGrid(movies: movies),
            RandomMovieButton(movies: movies),
          ],
        ),
      ),
    );
  }
}
