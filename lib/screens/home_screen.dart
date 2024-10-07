import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../styles/layouts.dart';
import '../widgets/movie_card/movie_card_model.dart';
import '../widgets/movie_card/movie_card.dart';
import '../widgets/nav_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CardSwiperController controller = CardSwiperController();

  final cards = movies.map(MovieCard.new).toList();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(child: HomeScreenContent(cards: cards, controller: controller));
  }
}

class HomeScreenContent extends StatelessWidget {
  final List cards;
  final CardSwiperController controller;

  const HomeScreenContent({super.key, required this.cards, required this.controller});

  void someAction() {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
            title: Text(
              'MoviePop',
              style: theme.textTheme.displayMedium?.copyWith(
                shadows: [
                  Shadow(
                    offset: Offset(1.0, 2.0),
                    blurRadius: 3.0,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
            ),
            iconTheme: theme.iconTheme,
            titleSpacing: 1),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Categories',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    // TODO: this shouldn't be hard-coded, ideally it should be read from database, for now we could extract those string into a constant variable
                    children: <Widget>[
                      Button(
                        text: Text(
                          'Comedy',
                          style: theme.textTheme.titleSmall,
                        ),
                        onPressed: someAction,
                      ),
                      Button(
                        text: Text(
                          'Romance',
                          style: theme.textTheme.titleSmall,
                        ),
                        onPressed: someAction,
                      ),
                      Button(
                        text: Text(
                          'Crime',
                          style: theme.textTheme.titleSmall,
                        ),
                        onPressed: someAction,
                      ),
                      Button(
                        text: Text(
                          'Documentary',
                          style: theme.textTheme.titleSmall,
                        ),
                        onPressed: someAction,
                      ),
                      Button(
                        text: Text(
                          'Drama',
                          style: theme.textTheme.titleSmall,
                        ),
                        onPressed: someAction,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: CardSwiper(
                    controller: controller,
                    cardsCount: cards.length,
                    onSwipe: _onSwipe,
                    onUndo: _onUndo,
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
                    FloatingActionButton(
                      onPressed: () => controller.swipe(CardSwiperDirection.left),
                      backgroundColor: Colors.black.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Icon(CupertinoIcons.clear, size: 25, color: Colors.white),
                    ),
                    FloatingActionButton(
                      onPressed: controller.undo,
                      backgroundColor: Colors.black.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Icon(CupertinoIcons.refresh, size: 25, color: Colors.white),
                    ),
                    FloatingActionButton(
                      onPressed: () => controller.swipe(CardSwiperDirection.right),
                      backgroundColor: Colors.black.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Icon(CupertinoIcons.heart, size: 25, color: Colors.white),
                    ),
                    ///MAYBE USEFUL IN THE FUTURE
                    // FloatingActionButton(
                    //   onPressed: () => controller.swipe(CardSwiperDirection.top),
                    //   child: const Icon(Icons.keyboard_arrow_up),
                    // ),
                    // FloatingActionButton(
                    //   onPressed: () =>
                    //       controller.swipe(CardSwiperDirection.bottom),
                    //   child: const Icon(Icons.keyboard_arrow_down),
                    // ),
                  ],
                ),
              ],
            )
        )
    );
  }
  bool _onSwipe(
      int previousIndex,
      int? currentIndex,
      CardSwiperDirection direction,
      ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool _onUndo(
      int? previousIndex,
      int currentIndex,
      CardSwiperDirection direction,
      ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }

}
