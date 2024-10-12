import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

import 'api_config.dart';
import 'package:zpi_project/models/movie.dart';
//import 'screens/widgets/movie_card_model.dart';

class MovieService {
  static Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/discover/movie?include_adult=false&include_video=false&language=pl-PL&page=1&sort_by=popularity.desc&api_key=${ApiConfig.apiKey}',
    ));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var logger = Logger();
      //logger.log(Level.info, data);
      final List<dynamic> results = data['results'];
      final movies = results.map((json) => Movie.fromJson(json)).toList();
      for (var movie in movies) {
        logger.i(movie.title);
      }
      return movies;
    } else {
      throw Exception('Failed to fetch movies');
    }
  }
}
