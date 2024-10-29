import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../styles/layouts.dart';
import '../widgets/movie_card/movie_card.dart';
import 'package:zpi_project/models/movie_model.dart';
import '../widgets/movie_card/swipe_utils.dart';
import '../widgets/nav_drawer.dart';
import '../widgets/category_selector.dart';
import '../utils/check_login_status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CardSwiperController controller = CardSwiperController();
  final List<MovieCard> cards = movies.map((movie) => MovieCard(movie: movie)).toList();
  //List<String> _selectedCategories = []; //will be needed when implementing filtering

  @override
  void initState() {
    super.initState();
    checkLoginStatus(context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onCategoriesSelected(List<String> selectedCategories) {
    setState(() {
      //_selectedCategories = selectedCategories;

    });
    // Additional logic can go here (like filtering cards by category).
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: HomeScreenContent(
        cards: cards,
        controller: controller,
        onCategoriesSelected: _onCategoriesSelected,
      ),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  final List<MovieCard> cards;
  final CardSwiperController controller;
  final ValueChanged<List<String>> onCategoriesSelected;

  const HomeScreenContent({
    super.key,
    required this.cards,
    required this.controller,
    required this.onCategoriesSelected,
  });

  @override // Add the @override annotation here
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      drawer: NavDrawer(),
      appBar: CustomAppBar(text: localizations.appTitle),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.categories,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            CategorySelector(
              categories: [
                localizations.comedy,
                localizations.romance,
                localizations.crime,
                localizations.documentary,
                localizations.drama,
              ],
              onCategorySelected: onCategoriesSelected,
            ),
            const SizedBox(height: 10),
            Flexible(
              child: CardSwiper(
                controller: controller,
                cardsCount: cards.length,
                onSwipe: SwipeUtils.onSwipe,
                onUndo: SwipeUtils.onUndo,
                numberOfCardsDisplayed: 2,
                padding: const EdgeInsets.all(10.0),
                cardBuilder: (
                    context,
                    index,
                    horizontalThresholdPercentage,
                    verticalThresholdPercentage,
                    ) =>
                cards[index],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SwipeButton(
                  icon: CupertinoIcons.clear,
                  onPressed: () => controller.swipe(CardSwiperDirection.left),
                  heroTag: "left_tag",
                ),
                SwipeButton(
                  icon: CupertinoIcons.refresh,
                  onPressed: controller.undo,
                  heroTag: "undo_tag",
                ),
                SwipeButton(
                  icon: CupertinoIcons.heart,
                  onPressed: () => controller.swipe(CardSwiperDirection.right),
                  heroTag: "heart_tag",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


final List<Movie> movies = [
  Movie(
    id: 1,
    title: 'Avengers',
    overview: 'Avengers saving the world...',
    posterPath: 'https://image.tmdb.org/t/p/original/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg',
    voteAverage: 8.5,
    releaseDate: '2012-05-04',
    isForAdults: false,
    categories: ['Action', 'Sci-Fi'],
  ),
  Movie(
    id: 2,
    title: 'Forrest Gump',
    overview: 'Life story of Forrest...',
    posterPath: 'https://image.tmdb.org/t/p/original/iixrNXX79OR7knBx1i9S51PfVlz.jpg',
    voteAverage: 8.8,
    releaseDate: '1994-07-06',
    isForAdults: false,
    categories: ['Drama', 'Romance'],
  ),
  Movie(
    id: 533535,
    title: 'Deadpool & Wolverine',
    overview: 'Wolverine teams up with Deadpool...',
    posterPath: 'https://image.tmdb.org/t/p/w500/7Hi6mRLsQtTaEtKiHqSeRFR1TQ2.jpg',
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
    posterPath: 'https://image.tmdb.org/t/p/original/rNzQyW4f8B8cQeg7Dgj3n6eT5k9.jpg',
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
    posterPath: 'https://image.tmdb.org/t/p/original/fXm3YKXAEjx7d2tIWDg9TfRZtsU.jpg',
    voteAverage: 7.0,
    releaseDate: '2004-04-30',
    isForAdults: false,
    categories: ['Comedy', 'Teen'],
  ),
];
