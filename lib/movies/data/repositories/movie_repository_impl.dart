import '../../domain/entities/movie.dart';
import 'package:zpi_project/movies/domain/repositories/movie_repositorie.dart';
import '../data_sources/movie_remote_data_source.dart';
import '../cache/genre_cache.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Movie>> fetchMovies() async {
    final genreMap = await getGenres();

    final moviesData = await remoteDataSource.fetchMovies();
    return moviesData.map((json) => Movie.fromJson(json, genreMap)).toList();
  }

  Future<Map<int, String>> getGenres() async {
    if (GenreCache.instance.genres != null) {
      return GenreCache.instance.genres!;
    }

    final genres = await remoteDataSource.fetchGenres();
    GenreCache.instance.setGenres(genres);
    return genres;
  }

  Future<Map<int, String>> getRealTimeGenres() async {
    final genres = await remoteDataSource.fetchGenres();
    return genres;
  }

}
