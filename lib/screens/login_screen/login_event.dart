part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  final AppLocalizations localizations;

  const LoginButtonPressed({required this.email, required this.password, required this.localizations});

  @override
  List<Object> get props => [email, password, localizations];

  @override
  String toString() =>
      'LoginButtonPressed { email: $email, password: $password }';
}

class LoginWithFacebookPressed extends LoginEvent {
  final AppLocalizations localizations;

  const LoginWithFacebookPressed({required this.localizations});

  @override
  List<Object> get props => [localizations];
}
