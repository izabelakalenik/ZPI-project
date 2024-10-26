part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmailPasswordEntered extends RegisterEvent {
  final String email;
  final String password;

  EmailPasswordEntered({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class UserDetailsEntered extends RegisterEvent {
  final String name;
  final String username;
  final int birthYear;
  final String country;
  final String gender;

  UserDetailsEntered({required this.name, required this.username, required this.birthYear, required this.country, required this.gender});

  @override
  List<Object?> get props => [name, username, birthYear, gender];
}

class GenresSelected extends RegisterEvent {
  final List<String> genres;

  GenresSelected({required this.genres});

  @override
  List<Object?> get props => [genres];
}

class SubmitRegistration extends RegisterEvent {}
