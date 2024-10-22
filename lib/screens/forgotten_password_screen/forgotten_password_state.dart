part of 'forgotten_password_bloc.dart';

abstract class ForgottenPasswordState extends Equatable {
  const ForgottenPasswordState();

  @override
  List<Object> get props => [];
}

class ForgottenPasswordInitial extends ForgottenPasswordState {}

class ForgottenPasswordLoading extends ForgottenPasswordState {}

class ForgottenPasswordSuccess extends ForgottenPasswordState {}

class ForgottenPasswordFailure extends ForgottenPasswordState {
  final String error;

  const ForgottenPasswordFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ForgottenPasswordFailure { error: $error }';
}
