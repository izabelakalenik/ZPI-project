abstract class RegisterEvent {}

class RegisterWithEmailAndPassword extends RegisterEvent {
  final String email;
  final String password;

  RegisterWithEmailAndPassword({required this.email, required this.password});
}

class RegisterAdditionalInfo extends RegisterEvent {
  final String name;
  final String username;
  final String birthYear;
  final String gender;

  RegisterAdditionalInfo({
    required this.name,
    required this.username,
    required this.birthYear,
    required this.gender,
  });
}

class RegisterFavoriteGenres extends RegisterEvent {
  final List<String> favoriteGenres;

  RegisterFavoriteGenres({required this.favoriteGenres});
}
