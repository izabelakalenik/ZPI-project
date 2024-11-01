import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zpi_project/database_configuration/authentication_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationService _authService = AuthenticationService();

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<LoginWithFacebookPressed>(_onLoginWithFacebookPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final localizations = event.localizations;
    try {
      // UserCredential userCredential =
      await _authService.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'invalid-email') {
        errorMessage = localizations.not_email;
      } else if (e.code == 'invalid-credential') {
        errorMessage = localizations.invalid_credentials;
      } else {
        errorMessage = localizations.unknown_error;
      }
      emit(LoginFailure(error: errorMessage));
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }

  Future<void> _onLoginWithFacebookPressed(
    LoginWithFacebookPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final localizations = event.localizations;

    try {
      final userCredential = await _authService.signInWithFacebook();
      if (userCredential != null) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(error: localizations.unknown_error));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-does-not-exist') {
        emit(LoginFailure(error: localizations.dont_have_an_account));
      }
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }
}
