class MovieCardModel {
  final String title;
  final String director;
  final String description;
  final String poster;

  MovieCardModel({
    required this.title,
    required this.director,
    required this.description,
    required this.poster,
  });
}

// This will be derived from API
final List<MovieCardModel> movies = [
  MovieCardModel(
    title: 'Forest Gump',
    director: 'Robert Zemeckis',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
    poster: 'assets/forrest_gump.jpg',
  ),
  MovieCardModel(
    title: 'Interstellar',
    director: 'Christopher Nolan',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
    poster: 'assets/interstellar.jpg',
  ),
  MovieCardModel(
    title: 'Avengers: Age of Ultron',
    director: 'Joss Whedon',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
    poster: 'assets/avengers_2.jpg',
  ),
  MovieCardModel(
    title: 'The Hobbit: An Unexpected Journey',
    director: 'Peter Jackson',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
    poster: 'assets/hobbit.jpg',
  ),
];