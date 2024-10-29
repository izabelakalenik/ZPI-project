class GenreCache {
  static final GenreCache _instance = GenreCache._internal();
  Map<int, String>? _genres;

  GenreCache._internal();

  static GenreCache get instance => _instance;

  Map<int, String>? get genres => _genres;
  //set genres(Map<int, String>? genres) => _genres = genres;
  void setGenres(Map<int, String>? genres) {
    _genres = genres;
  }
}
