import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());

    try {
      // UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'invalid-email') {
        errorMessage = "That don't look like an email";
      } else if (e.code == 'invalid-credential') {
        errorMessage = "The password or the e-mail address is incorrect";
      } else {
        errorMessage = 'An unknown error occurred';
      }
      emit(LoginFailure(error: errorMessage));
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }
}
