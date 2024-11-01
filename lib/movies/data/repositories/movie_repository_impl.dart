import 'dart:convert';

import '../../../api/api_config.dart';
import '../../../languages/localization_utils.dart';
import '../../domain/entities/movie.dart';
import 'package:zpi_project/movies/domain/repositories/movie_repositorie.dart';
import '../data_sources/movie_remote_data_source.dart';
import '../cache/genre_cache.dart';
import 'package:http/http.dart' as http;


class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Movie>> fetchMovies() async {
    final genreMap = await _getGenres();

    final moviesData = await remoteDataSource.fetchMovies();
    return moviesData.map((json) => Movie.fromJson(json, genreMap)).toList();
  }

  Future<Map<int, String>> _getGenres() async {
    if (GenreCache.instance.genres != null) {
      return GenreCache.instance.genres!;
    }

    final genres = await remoteDataSource.fetchGenres();
    GenreCache.instance.setGenres(genres);
    return genres;
  }

  Future<List<Movie>> fetchLikedMovies(List<int> likedMovieIds) async {
    List<Movie> likedMovies = [];

    final languageCode = LocalizationUtils.instance.locale.languageCode;
    final countryCode = LocalizationUtils.instance.locale.countryCode;

    final language = countryCode != null && countryCode.isNotEmpty
        ? '$languageCode-$countryCode'
        : languageCode;

    for (var movieId in likedMovieIds) {
      final response = await http.get(Uri.parse(
        '${ApiConfig.baseUrl}/movie/$movieId?api_key=${ApiConfig.apiKey}&language=$language',
      ));

      if (response.statusCode == 200) {
        final movieData = json.decode(response.body);
        likedMovies.add(Movie.fromJson(movieData, await _getGenres()));
      } else {
        throw Exception('Failed to load movie with ID: $movieId');
      }
    }

    return likedMovies;
  }

}
