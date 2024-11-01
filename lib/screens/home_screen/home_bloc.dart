import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zpi_project/movies/domain/entities/movie.dart';
import 'package:zpi_project/movies/domain/repositories/movie_repositorie.dart';
import 'package:zpi_project/movies/data/data_sources/movie_remote_data_source.dart';
import 'package:zpi_project/movies/data/repositories/movie_repository_impl.dart';
import 'package:logger/logger.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieRepository _movieRepository;
  int currentIndex = 0;
  var logger = Logger();

  HomeBloc()
      : _movieRepository = MovieRepositoryImpl(MovieRemoteDataSource()),
        super(HomeInitial()) {
    on<LoadInitialCards>(_onLoadInitialCards);
    on<LoadMoreCards>(_onLoadMoreCards);
    on<CardSwipedLeft>(_onCardSwipedLeft);
    on<CardSwipedRight>(_onCardSwipedRight);
    on<CardUndo>(_onCardUndo);
  }

  Future<void> _onLoadInitialCards(
    LoadInitialCards event,
    Emitter<HomeState> emit,
  ) async {
    emit(InitializeNotFinished());
    try {
      List<Movie> initialMovies = await _movieRepository.fetchMovies();
      emit(state.copyWith(
          movies: initialMovies,
          isLoadingMore: false,
          currentIndex: currentIndex));
    } catch (error) {
      emit(HomeFailure(error: error.toString()));
    }
  }

  // we can implement this technic to ask api for more movies before we ran out of the existing ones (to make user wait less, this gmail hack)
  Future<void> _onLoadMoreCards(
    LoadMoreCards event,
    Emitter<HomeState> emit,
  ) async {
    emit(AddingMoviesNotFinished(
        movies: state.movies, currentIndex: currentIndex));
    try {
      logger.log(Level.info, "loading more movies is turn on");
      List<Movie> moreMovies = await _movieRepository.fetchMovies();
      emit(state.addMovies(movies: moreMovies, currentIndex: currentIndex));
    } catch (error) {
      emit(HomeFailure(error: error.toString()));
    }
  }

  Future<void> _onCardSwipedLeft(
    CardSwipedLeft event,
    Emitter<HomeState> emit,
  ) async {
    logger.log(Level.info, "Card was swiped Left");
    //here we have to add event.movie.it to the firebase user liked movies
    currentIndex++;
    if (currentIndex >= state.movies.length) {
      add(LoadMoreCards());
    }
  }

  Future<void> _onCardSwipedRight(
    CardSwipedRight event,
    Emitter<HomeState> emit,
  ) async {
    logger.log(Level.info, "Card was swiped Right");
    //here we have to add event.movie.it to the firebase user disliked movies
    currentIndex++;
    if (currentIndex >= state.movies.length) {
      add(LoadMoreCards());
    }
  }

  Future<void> _onCardUndo(
    CardUndo event,
    Emitter<HomeState> emit,
  ) async {
    logger.log(Level.info, "There is card Undo");
    //here we have to remove event.movie.it from the firebase user disliked or liked movies
    if (currentIndex > 0) currentIndex--;
  }
}
