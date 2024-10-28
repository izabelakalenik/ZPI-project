part of 'register_bloc.dart';
abstract class RegisterEvent extends Equatable {
  final AppLocalizations localizations;

  const RegisterEvent({required this.localizations});

  @override
  List<Object?> get props => [localizations];
}

class EmailPasswordEntered extends RegisterEvent {
  final String email;
  final String password;

  const EmailPasswordEntered({
    required super.localizations,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password, localizations];
}

class UserDetailsEntered extends RegisterEvent {
  final String name;
  final String username;
  final int birthYear;
  final String country;
  final String gender;

  const UserDetailsEntered({
    required super.localizations,
    required this.name,
    required this.username,
    required this.birthYear,
    required this.country,
    required this.gender,
  });

  @override
  List<Object?> get props => [name, username, birthYear, country, gender, localizations];
}

class GenresSelected extends RegisterEvent {
  final List<String> genres;

  const GenresSelected({
    required super.localizations,
    required this.genres,
  });

  @override
  List<Object?> get props => [genres, localizations];
}

class SubmitRegistration extends RegisterEvent {
  const SubmitRegistration({required super.localizations});
}

class CheckUsernameAvailability extends RegisterEvent {
  final String username;

  const CheckUsernameAvailability({
    required super.localizations,
    required this.username,
  });

  @override
  List<Object?> get props => [username, localizations];
}