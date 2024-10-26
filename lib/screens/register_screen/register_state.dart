part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final String email;
  final String password;
  final String name;
  final String username;
  final int birthYear;
  final String gender;
  final String country;
  final List<String> genres;

  RegisterState({
    this.email = '',
    this.password = '',
    this.name = '',
    this.username = '',
    this.birthYear = 0,
    this.gender = '',
    this.country = 'Poland',
    this.genres = const [],
  });

  RegisterState copyWith({
    String? email,
    String? password,
    String? name,
    String? username,
    int? birthYear,
    String? gender,
    String? country,
    List<String>? genres,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      username: username ?? this.username,
      birthYear: birthYear ?? this.birthYear,
      gender: gender ?? this.gender,
      country: country?? this.country,
      genres: genres ?? this.genres,
    );
  }

  @override
  List<Object?> get props => [email, password, name, username, birthYear, gender, genres];
}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure({required this.error});
}