part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ResetPasswordButtonPressed extends ResetPasswordEvent {
  final String password;
  final String repeated_password;

  const ResetPasswordButtonPressed(
      {required this.password, required this.repeated_password});

  @override
  List<Object> get props => [password, repeated_password];

  @override
  String toString() =>
      'ResetPasswordButtonPressed { password: $password, repeated_password: $repeated_password}';
}
