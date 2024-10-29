class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final String releaseDate;
  final bool isForAdults;
  final List<String> categories;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.isForAdults,
    required this.categories,
  });

  factory Movie.fromJson(Map<String, dynamic> json, Map<int, String> genreMap) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      voteAverage: json['vote_average'].toDouble(),
      releaseDate: json['release_date'],
      isForAdults: json['adult'],
      categories: (json['genre_ids'] as List<dynamic>?)
              ?.map((id) => genreMap[id] ?? 'Unknown')
              .toList() ??
          [],
    );
  }
}
