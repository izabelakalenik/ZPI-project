import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zpi_project/screens/home_screen/home_bloc.dart';

import '../../styles/layouts.dart';
import '../widgets/movie_card/modal_bottom_sheet.dart';
import '../widgets/movie_card/movie_card.dart';
import '../../widgets/movie_card/swipe_utils.dart';
import '../../widgets/nav_drawer.dart';
import '../../widgets/category_selector.dart'; // Import the CategorySelector

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CardSwiperController controller = CardSwiperController();
  late List<MovieCard> cards; // Declare cards as late
  //List<String> _selectedCategories = []; //will be needed when implementing filtering

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
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadInitialCards());

    cards = movies.map((movie) {
      return MovieCard(
        movie: movie,
        onPressed: () => _openIconButtonPressed(movie), // Pass the movie to the handler
      );
    }).toList();
  }

  void _openIconButtonPressed(Movie movie) {
    showModalBottomSheet(
      isScrollControlled: true, // This is important to allow custom height
      context: context,
      builder: (ctx) => ModalBottomSheet(movie: movie), // Pass the movie to the modal
    );
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

  @override
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
            // categories
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

            // end of categories
            const SizedBox(height: 10),
            Flexible(
              child:
                  BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                if (state is InitializeNotFinished) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state.movies.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                return CardSwiper(
                  controller: controller,
                  cardsCount: state.movies.length,
                  onSwipe: SwipeUtils.onSwipe,
                  numberOfCardsDisplayed: 2,
                  padding: const EdgeInsets.all(5.0),
                  cardBuilder: (context, index, _, __) =>
                      MovieCard(movie: state.movies[index]),
                );
              }),
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
