import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../styles/layouts.dart';
import '../widgets/movie_card/movie_card_model.dart';
import '../widgets/movie_card/movie_card.dart';
import '../widgets/movie_card/swipe_utils.dart';
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
    return MainLayout(
        child: HomeScreenContent(cards: cards, controller: controller));
  }
}

class HomeScreenContent extends StatelessWidget {
  final List cards;
  final CardSwiperController controller;

  const HomeScreenContent(
      {super.key, required this.cards, required this.controller});

  void someAction() {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      drawer: NavDrawer(),
      appBar: CustomAppBar(text: AppLocalizations.of(context)!.appTitle),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.categories,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  // This will be derived from API
                  Button(
                    text: Text(
                      AppLocalizations.of(context)!.comedy,
                      style: theme.textTheme.titleSmall,
                    ),
                    onPressed: someAction,
                  ),
                  Button(
                    text: Text(
                      AppLocalizations.of(context)!.romance,
                      style: theme.textTheme.titleSmall,
                    ),
                    onPressed: someAction,
                  ),
                  Button(
                    text: Text(
                      AppLocalizations.of(context)!.crime,
                      style: theme.textTheme.titleSmall,
                    ),
                    onPressed: someAction,
                  ),
                  Button(
                    text: Text(
                      AppLocalizations.of(context)!.documentary,
                      style: theme.textTheme.titleSmall,
                    ),
                    onPressed: someAction,
                  ),
                  Button(
                    text: Text(
                      AppLocalizations.of(context)!.drama,
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
