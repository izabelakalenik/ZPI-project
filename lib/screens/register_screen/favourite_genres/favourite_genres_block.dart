import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../movies/data/repositories/movie_repository_impl.dart';
import 'favourite_genres_event.dart';
import 'favourite_genres_state.dart';

class FavouriteGenresBloc extends Bloc<FavouriteGenresEvent, FavouriteGenresState> {
  final MovieRepositoryImpl movieRepository;

  FavouriteGenresBloc({required this.movieRepository}) : super(const FavouriteGenresState()) {
    on<LoadGenres>(_onLoadGenres);
  }

  Future<void> _onLoadGenres(
      LoadGenres event, Emitter<FavouriteGenresState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final genres = await movieRepository.getRealTimeGenres();
      emit(state.copyWith(genres: genres, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      debugPrint(e.toString());
    }
  }
}