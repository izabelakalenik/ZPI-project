import 'package:flutter/material.dart';
import 'api/movie_service.dart';

import 'app.dart';

void main() {
  runApp(const App());
  MovieService.fetchMovies();
}
