import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zpi_project/screens/home_screen/home_bloc.dart';
import 'package:logger/logger.dart';

class SwipeUtils {
  var logger = Logger();

  static bool onSwipe(
    BuildContext context,
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    final bloc = context.read<HomeBloc>();
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    final movie = bloc.state.movies[previousIndex];
    if (direction == CardSwiperDirection.left) {
      bloc.add(CardSwipedLeft(movie));
    } else if (direction == CardSwiperDirection.right) {
      bloc.add(CardSwipedRight(movie));
    }
    return true;
  }

  static bool onUndo(
    BuildContext context,
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    final bloc = context.read<HomeBloc>();
    debugPrint(
      'The card $currentIndex was undone from the ${direction.name}',
    );
    final movieIndex = previousIndex ?? currentIndex;
    if (movieIndex < bloc.state.movies.length) {
      final movie = bloc.state.movies[movieIndex];
      bloc.add(CardUndo(movie));
    }
    return true;
  }
}
