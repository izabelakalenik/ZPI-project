import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zpi_project/screens/home_screen/home_bloc.dart';

import '../../styles/layouts.dart';
import '../../widgets/detailed_movie_card/detailed_movie_card_front.dart';
import '../../widgets/movie_card/swipe_utils.dart';
import '../../widgets/nav_drawer.dart';
import '../../widgets/category_selector.dart'; // Import the CategorySelector
import 'package:logger/logger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CardSwiperController controller = CardSwiperController();
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
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: HomeScreenContent(
        controller: controller,
        onCategoriesSelected: _onCategoriesSelected,
      ),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  final CardSwiperController controller;
  final ValueChanged<List<String>> onCategoriesSelected;

  const HomeScreenContent({
    super.key,
    required this.controller,
    required this.onCategoriesSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    var logger = Logger();

    bool handleSwipe(
        int previousIndex, int? currentIndex, CardSwiperDirection direction) {
      return SwipeUtils.onSwipe(
          context, previousIndex, currentIndex, direction);
    }

    bool handleUndo(
        int? previousIndex, int currentIndex, CardSwiperDirection direction) {
      logger.log(Level.info, "handle undo");
      return SwipeUtils.onUndo(
          context, previousIndex, currentIndex, CardSwiperDirection.left);
    }

    // bool handleUndo2(int currentIndex) {
    //   logger.log(Level.info, "handle undo");
    //   int previousIndex = currentIndex--;
    //   return SwipeUtils.onUndo(
    //       context, 1, currentIndex, CardSwiperDirection.left);
    // }

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
                if (state is InitializeNotFinished ||
                    state is AddingMoviesNotFinished) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state.movies.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                logger.log(Level.info, state.movies.length);
                logger.log(Level.info, state.currentIndex);
                return Column(
                  children: [
                    Expanded(
                      child: CardSwiper(
                        controller: controller,
                        cardsCount: state.movies.length,
                        initialIndex: state.currentIndex,
                        onSwipe: handleSwipe,
                        onUndo: handleUndo,
                        numberOfCardsDisplayed: 1,
                        padding: const EdgeInsets.all(15.0),
                        cardBuilder: (context, index, _, __) =>
                            DetailedMovieCardFront(movie: state.movies[index]),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SwipeButton(
                          icon: CupertinoIcons.clear,
                          onPressed: () =>
                              controller.swipe(CardSwiperDirection.left),
                          heroTag: "left_tag",
                        ),
                        SwipeButton(
                          icon: CupertinoIcons.refresh,
                          //onPressed: () => handleUndo2(state.currentIndex),
                          onPressed: controller.undo,
                          heroTag: "undo_tag",
                        ),
                        SwipeButton(
                          icon: CupertinoIcons.heart,
                          onPressed: () =>
                              controller.swipe(CardSwiperDirection.right),
                          heroTag: "heart_tag",
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}