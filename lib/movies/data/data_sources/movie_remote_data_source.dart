import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zpi_project/api/api_config.dart';
import 'package:zpi_project/languages/localization_utils.dart'; //it should be put in different path ex lib/core/network/api_config.dart

class MovieRemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchMovies() async {
    final locale = LocalizationUtils.instance.locale;
    String localeString = '${locale.languageCode}-${locale.countryCode}';
    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/discover/movie?include_adult=false&include_video=false&language=$localeString&page=1&sort_by=popularity.desc&api_key=${ApiConfig.apiKey}',
    ));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['results']);
    } else {
      throw Exception('Failed to fetch movies');
    }
  }

  Future<Map<int, String>> fetchGenres() async {
    final locale = LocalizationUtils.instance.locale;
    String localeString = '${locale.languageCode}-${locale.countryCode}';

    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/genre/movie/list?language=$localeString&api_key=${ApiConfig.apiKey}',
    ));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> genresList = data['genres'];
      return {for (var genre in genresList) genre['id']: genre['name']};
    } else {
      throw Exception('Failed to fetch genres');
    }
  }
}
