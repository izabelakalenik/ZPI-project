import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../styles/layouts.dart';
import '../widgets/movie_card/movie_card.dart';
import '../widgets/movie_card/movie_card_model.dart';
import '../widgets/movie_card/swipe_utils.dart';
import '../widgets/nav_drawer.dart';
import '../widgets/category_selector.dart'; // Import the CategorySelector

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CardSwiperController controller = CardSwiperController();
  final List<MovieCard> cards = movies.map(MovieCard.new).toList();
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
                numberOfCardsDisplayed: 3,
                padding: const EdgeInsets.all(15.0),
                cardBuilder: (
                    context,
                    index,
                    horizontalThresholdPercentage,
                    verticalThresholdPercentage,
                    ) =>
                cards[index],
              ),
            ),
            const SizedBox(height: 40),
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
