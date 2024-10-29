part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<Movie> movies;
  final bool isLoadingMore;

  const HomeState({
    this.movies = const [],
    this.isLoadingMore = false,
  });
  // storing list of next movie in state is better then cach with freqent changes of the list

  HomeState copyWith({
    // to copy new state, have check this if it works correctly
    List<Movie>? movies,
    bool? isLoadingMore,
  }) {
    var logger = Logger();
    logger.log(Level.info, "wywołanie state");
    logger.log(Level.info, movies == null ? "movies is null" : movies.length);
    return HomeState(
      movies: movies ?? this.movies,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object> get props => [];
}

class InitializeNotFinished extends HomeState {}

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
