part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  final String email;
  final String password;
  // final String name;
  // final String nickname;
  // final int age;
  // final String gender;
  // final List<String>? favGenres;
  const RegisterButtonPressed({required this.email, required this.password/*, required this.name, required this.nickname, required this.age, required this.gender, required this.favGenres*/});

  @override
  List<Object> get props => [email, password/*, name, nickname, age, gender*/];

  @override
  String toString() => 'RegisterButtonPressed { email: $email, password: $password }';
}