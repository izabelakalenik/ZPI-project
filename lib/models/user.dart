class User {
  String username;
  String email;
  String password;
  String? country;

  User({
    required this.username,
    required this.email,
    required this.password,
    this.country,
  });
}
