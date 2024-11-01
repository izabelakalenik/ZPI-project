import 'package:equatable/equatable.dart';

class FavouriteGenresState extends Equatable {
  final Map<int, String> genres;
  final bool isLoading;

  const FavouriteGenresState({
    this.genres = const {},
    this.isLoading = false,
  });

  FavouriteGenresState copyWith({
    Map<int, String>? genres,
    bool? isLoading,
  }) {
    return FavouriteGenresState(
      genres: genres ?? this.genres,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [genres, isLoading];
}