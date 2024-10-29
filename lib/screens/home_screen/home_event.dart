//import 'package:zpi_project/movies/domain/entities/movie.dart';

part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadInitialCards extends HomeEvent {}

class LoadMoreCards extends HomeEvent {}

class CardSwipedLeft extends HomeEvent {
  // we want to pass movie, not the id, because this data might help in enhancing next movie suggestions

  final Movie movie;

  const CardSwipedLeft(this.movie);

  @override
  List<Object> get props => [movie];
}

class CardSwipedRight extends HomeEvent {
  final Movie movie;

  const CardSwipedRight(this.movie);

  @override
  List<Object> get props => [movie];
}

class CardUndo extends HomeEvent {
  final Movie movie;

  const CardUndo(this.movie);

  @override
  List<Object> get props => [movie];
}
