import 'dart:ffi';

class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final String releaseDate;
  final bool isForAdults;
  final List<String> categories;

  Movie(
      {required this.id,
      required this.title,
      required this.overview,
      required this.posterPath,
      required this.voteAverage,
      required this.releaseDate,
      required this.isForAdults,
      required this.categories});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        title: json['title'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        voteAverage: json['vote_average'].toDouble(),
        releaseDate: json['release_date'],
        isForAdults: json['adult'],
        categories: json[
            'genre_ids']); // we have to map genres!! Without maping it might generate errors
  }
}
