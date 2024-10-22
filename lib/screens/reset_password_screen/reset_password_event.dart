part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ResetPasswordButtonPressed extends ResetPasswordEvent {
  final String password;
  final String repeatedPassword;

  const ResetPasswordButtonPressed(
      {required this.password, required this.repeatedPassword});

  @override
  List<Object> get props => [password, repeatedPassword];

  @override
  String toString() =>
      'ResetPasswordButtonPressed { password: $password, repeated_password: $repeatedPassword}';
}
