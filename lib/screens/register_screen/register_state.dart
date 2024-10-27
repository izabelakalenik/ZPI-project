part of 'register_bloc.dart';

@immutable
class RegisterState extends Equatable {
  final String email;
  final String password;
  final String name;
  final String username;
  final int birthYear;
  final String gender;
  final String country;
  final List<String> genres;

  const RegisterState({
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
      country: country ?? this.country,
      genres: genres ?? this.genres,
    );
  }

  @override
  List<Object?> get props => [email, password, name, username, birthYear, gender, country, genres];
}

class RegisterProceedToSecondScreen extends RegisterState {
  const RegisterProceedToSecondScreen({
    required String email,
    required String password,
    String name = '',
    String username = '',
    int birthYear = 0,
    String gender = '',
    String country = 'Poland',
    List<String> genres = const [],
  }) : super(
    email: email,
    password: password,
    name: name,
    username: username,
    birthYear: birthYear,
    gender: gender,
    country: country,
    genres: genres,
  );
}

class RegisterProceedToFavGenresScreen extends RegisterProceedToSecondScreen {
  const RegisterProceedToFavGenresScreen({
    required String email,
    required String password,
    required String name,
    required String username,
    required int birthYear,
    required String country,
    required String gender,
    List<String> genres = const [],
  }) : super(
    email: email,
    password: password,
    name: name,
    username: username,
    birthYear: birthYear,
    country: country,
    gender: gender,
    genres: genres,
  );
}

class RegisterComplete extends RegisterProceedToFavGenresScreen {
  const RegisterComplete({
    required String email,
    required String password,
    required String name,
    required String username,
    required int birthYear,
    required String country,
    required String gender,
    required List<String> genres,
  }) : super(
    email: email,
    password: password,
    name: name,
    username: username,
    birthYear: birthYear,
    country: country,
    gender: gender,
    genres: genres,
  );
}

class RegisterInitial extends RegisterState {
  const RegisterInitial() : super();
}

class RegisterLoading extends RegisterState {
  const RegisterLoading() : super();
}

class RegisterFailure extends RegisterState {
  final String error;

  const RegisterFailure({required this.error}) : super();

  @override
  List<Object?> get props => super.props + [error];
}
