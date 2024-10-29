import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zpi_project/movies/domain/entities/movie.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  //final MovieRepository movieRepository;

  HomeBloc() : super(HomeInitial()) {
    on<LoadInitialCards>(_onLoadInitialCards);
    on<CardSwipedLeft>(_onCardSwipedLeft);
    on<CardSwipedRight>(_onCardSwipedRight);
    on<CardUndo>(_onCardUndo);
  }

  Future<void> _onLoadInitialCards(
    LoadInitialCards event,
    Emitter<HomeState> emit,
  ) async {
    emit(InitializeNotFinished());
    final sampleMovies = [
      Movie(
        id: 1,
        title: 'Movie 1',
        overview: 'Overview of Movie 1',
        posterPath:
            'https://image.tmdb.org/t/p/w500//v9acaWVVFdZT5yAU7J2QjwfhXyD.jpg',
        voteAverage: 8.1,
        releaseDate: '2021-01-01',
        isForAdults: false,
        categories: ['Action', 'Drama'],
      ),
      Movie(
        id: 2,
        title: 'Movie 2',
        overview: 'Overview of Movie 2',
        posterPath:
            'https://image.tmdb.org/t/p/w500//3V4kLQg0kSqPLctI5ziYWabAZYF.jpg',
        voteAverage: 7.5,
        releaseDate: '2021-02-01',
        isForAdults: false,
        categories: ['Comedy', 'Romance'],
      ),
      Movie(
        id: 3,
        title: 'Movie 3',
        overview: 'Overview of Movie 3',
        posterPath:
            'https://image.tmdb.org/t/p/w500//v9acaWVVFdZT5yAU7J2QjwfhXyD.jpg',
        voteAverage: 6.3,
        releaseDate: '2021-03-01',
        isForAdults: true,
        categories: ['Horror', 'Thriller'],
      ),
      Movie(
        id: 4,
        title: 'Movie 4',
        overview: 'Overview of Movie 4',
        posterPath:
            'https://image.tmdb.org/t/p/w500//3V4kLQg0kSqPLctI5ziYWabAZYF.jpg',
        voteAverage: 9.0,
        releaseDate: '2021-04-01',
        isForAdults: false,
        categories: ['Adventure', 'Fantasy'],
      ),
      Movie(
        id: 5,
        title: 'Movie 5',
        overview: 'Overview of Movie 5',
        posterPath: 'https://example.com/poster5.jpg',
        voteAverage: 7.8,
        releaseDate: '2021-05-01',
        isForAdults: false,
        categories: ['Sci-Fi', 'Action'],
      ),
    ];

    emit(state.copyWith(movies: sampleMovies, isLoadingMore: false));
  }

  Future<void> _onCardSwipedLeft(
    CardSwipedLeft event,
    Emitter<HomeState> emit,
  ) async {}

  Future<void> _onCardSwipedRight(
    CardSwipedRight event,
    Emitter<HomeState> emit,
  ) async {}

  Future<void> _onCardUndo(
    CardUndo event,
    Emitter<HomeState> emit,
  ) async {}
}
