class UserModel {
  String email;
  String password;
  String name;
  String username;
  int birthYear;
  String gender;
  String country;
  List<String> favoriteGenres;

  UserModel({
    required this.email,
    required this.password,
    required this.name,
    required this.username,
    required this.birthYear,
    required this.gender,
    required this.country,
    required this.favoriteGenres,
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
    );
  }
}