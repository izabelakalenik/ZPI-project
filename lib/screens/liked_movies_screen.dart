import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/movie_model.dart';
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
  List<String> _selectedCategories = [];

  @override
  void initState() {
    super.initState();
    checkLoginStatus(context);
  }

  final List<Movie> _allMovies = [
    Movie(
      id: 1,
      title: 'Avengers',
      overview: 'Avengers saving the world...',
      posterPath:
          'https://image.tmdb.org/t/p/original/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg',
      voteAverage: 8.5,
      releaseDate: '2012-05-04',
      isForAdults: false,
      categories: ['Action', 'Sci-Fi'],
    ),
    Movie(
      id: 2,
      title: 'Forrest Gump',
      overview: 'Life story of Forrest...',
      posterPath:
          'https://image.tmdb.org/t/p/original/iixrNXX79OR7knBx1i9S51PfVlz.jpg',
      voteAverage: 8.8,
      releaseDate: '1994-07-06',
      isForAdults: false,
      categories: ['Drama', 'Romance'],
    ),
    Movie(
      id: 533535,
      title: 'Deadpool & Wolverine',
      overview: 'Wolverine teams up with Deadpool...',
      posterPath:
          'https://image.tmdb.org/t/p/w500/7Hi6mRLsQtTaEtKiHqSeRFR1TQ2.jpg',
      voteAverage: 7.722,
      releaseDate: "2024-07-26",
      isForAdults: false,
      categories: ['Action', 'Comedy', 'Documentary'],
    ),
    Movie(
      id: 3,
      title: 'The Notebook',
      overview:
          'A poor yet passionate young man falls in love with a rich young woman, giving her a sense of freedom. They enjoy a romantic summer together but are soon separated.',
      posterPath:
          'https://image.tmdb.org/t/p/original/rNzQyW4f8B8cQeg7Dgj3n6eT5k9.jpg',
      voteAverage: 7.8,
      releaseDate: '2004-06-25',
      isForAdults: false,
      categories: ['Drama', 'Romance'],
    ),
    Movie(
      id: 4,
      title: 'Mean Girls',
      overview:
          'Cady Heron is a hit with The Plastics, the A-list girl clique at her new school. But her popularity comes with a price.',
      posterPath:
          'https://image.tmdb.org/t/p/original/fXm3YKXAEjx7d2tIWDg9TfRZtsU.jpg',
      voteAverage: 7.0,
      releaseDate: '2004-04-30',
      isForAdults: false,
      categories: ['Comedy', 'Teen'],
    ),
  ];

  List<Movie> get _filteredMovies {
    if (_selectedCategories.isEmpty) return _allMovies;
    return _allMovies.where((movie) {
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
