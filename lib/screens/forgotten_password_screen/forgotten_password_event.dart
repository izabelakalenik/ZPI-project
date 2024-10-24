part of 'forgotten_password_bloc.dart';

abstract class ForgottenPasswordEvent extends Equatable {
  const ForgottenPasswordEvent();

  @override
  List<Object> get props => [];
}

class SendButtonPressed extends ForgottenPasswordEvent {
  final String email;
  final AppLocalizations localizations;

  const SendButtonPressed({required this.email, required this.localizations});

  @override
  List<Object> get props => [
        email,
      ];

  @override
  String toString() => 'RegisterButtonPressed { email: $email}';
}
