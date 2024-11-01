part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<Movie> movies;
  final bool isLoadingMore;
  final int currentIndex;

  const HomeState({
    this.movies = const [],
    this.isLoadingMore = false,
    this.currentIndex = 0,
  });
  // storing list of next movie in state is better then cach with freqent changes of the list

  HomeState copyWith({
    // to copy new state, have check this if it works correctly
    List<Movie>? movies,
    bool? isLoadingMore,
    int? currentIndex,
  }) {
    return HomeState(
      movies: movies ?? this.movies,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  HomeState addMovies({
    List<Movie>? movies,
    bool? isLoadingMore,
    int? currentIndex,
  }) {
    final updatedMovies =
        movies != null ? [...this.movies, ...movies] : this.movies;
    return HomeState(
      movies: updatedMovies,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object> get props => [];
}

class InitializeNotFinished extends HomeState {}

class AddingMoviesNotFinished extends HomeState {
  const AddingMoviesNotFinished({
    required List<Movie> movies,
    required int currentIndex,
  }) : super(movies: movies, currentIndex: currentIndex);
}

// check after implementing all backend, do we need that many states?
class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {}

class HomeFailure extends HomeState {
  final String error;

  const HomeFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'HomeFailure { error: $error }';
}
