part of 'forgotten_password_bloc.dart';

abstract class ForgottenPasswordEvent extends Equatable {
  const ForgottenPasswordEvent();

  @override
  List<Object> get props => [];
}

class SendButtonPressed extends ForgottenPasswordEvent {
  final String email;

  const SendButtonPressed({required this.email});

  @override
  List<Object> get props => [
        email,
      ];

  @override
  String toString() => 'RegisterButtonPressed { email: $email}';
}
