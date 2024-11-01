import 'package:equatable/equatable.dart';

abstract class FavouriteGenresEvent extends Equatable {
  const FavouriteGenresEvent();

  @override
  List<Object> get props => [];
}

class LoadGenres extends FavouriteGenresEvent {}

class GenresLoaded extends FavouriteGenresEvent {
  final Map<int, String> genres;

  const GenresLoaded(this.genres);

  @override
  List<Object> get props => [genres];
}