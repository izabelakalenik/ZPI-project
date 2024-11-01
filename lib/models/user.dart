class UserModel {
  String email;
  String password;
  String name;
  String username;
  int birthYear;
  String gender;
  String country;
  List<String> favoriteGenres;
  List<int> likedMovies;
  List<int> dislikedMovies;

  UserModel({
    required this.email,
    required this.password,
    required this.name,
    required this.username,
    required this.birthYear,
    required this.gender,
    required this.country,
    required this.favoriteGenres,
    this.likedMovies = const [],
    this.dislikedMovies = const [],
  });

  UserModel copyWith({
    String? email,
    String? password,
    String? name,
    String? username,
    int? birthYear,
    String? gender,
    String? country,
    List<String>? favoriteGenres,
    List<int>? likedMovies,
    List<int>? dislikedMovies,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      username: username ?? this.username,
      birthYear: birthYear ?? this.birthYear,
      gender: gender ?? this.gender,
      country: country ?? this.country,
      favoriteGenres: favoriteGenres ?? this.favoriteGenres,
      likedMovies: likedMovies ?? this.likedMovies,
      dislikedMovies: dislikedMovies ?? this.dislikedMovies,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'username': username,
      'birthYear': birthYear,
      'gender': gender,
      'country': country,
      'favoriteGenres': favoriteGenres,
      'likedMovies': likedMovies,
      'dislikedMovies': dislikedMovies,
    };
  }
}