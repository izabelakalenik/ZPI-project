import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zpi_project/database_configuration/firestore_service.dart';

import '../../database_configuration/authentication_service.dart';
import '../../models/user.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    final AuthenticationService authService = AuthenticationService();
    final FirestoreService firestoreService = FirestoreService();

    on<EmailPasswordEntered>((event, emit) async {
      final emailRegex =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      final passwordRegex =
          RegExp(r'^(?=.*[0-9])(?=.*[!@#$%^&*\.])[A-Za-z\d!@#$%^&*\.]{6,}$');

      if (!emailRegex.hasMatch(event.email)) {
        emit(RegisterFailure(
            error: event.localizations.not_email, user: state.user));
        emit(RegisterInitial());
        return;
      }

      final isUnique = await firestoreService.isEmailUnique(event.email);
      if (!isUnique) {
        emit(RegisterFailure(
            error: event.localizations.email_taken, user: state.user));
        emit(RegisterInitial());
        return;
      }

      if (!passwordRegex.hasMatch(event.password)) {
        emit(RegisterFailure(
            error: event.localizations.invalid_password, user: state.user));
        emit(RegisterInitial());
        return;
      }

      emit(RegisterProceed(
          state.user.copyWith(email: event.email, password: event.password)));
    });

    on<UserDetailsEntered>((event, emit) async {
      final isUnique = await firestoreService.isUsernameUnique(event.username);
      if (!isUnique) {
        emit(RegisterFailure(
            error: event.localizations.username_taken, user: state.user));
      } else {
        emit(RegisterProceed(state.user.copyWith(
            name: event.name,
            username: event.username,
            birthYear: event.birthYear,
            country: "Poland",
            gender: event.gender)));
      }
    });

    on<GenresSelected>((event, emit) {
      final updatedUser = state.user.copyWith(favoriteGenres: event.genres);
      emit(state.copyWith(user: updatedUser));
    });

    on<SubmitRegistration>((event, emit) async {
      // if password is not set - user was registered with facebook
      if (state.user.password == '') {
        state.user.email = await authService.getEmailFromFacebook();
      } else {
        await authService.registerUser(state.user);
        await authService.signInWithEmailAndPassword(
            email: state.user.email, password: state.user.password);
      }
      firestoreService.saveUser(state.user, authService.getCurrentUser()!.uid);

      emit(RegisterInitial()); // Reset state
    });

    on<CheckUsernameAvailability>((event, emit) async {
      final isUnique = await firestoreService.isUsernameUnique(event.username);
      if (!isUnique) {
        emit(RegisterUsernameTaken(
            error: event.localizations.username_taken, user: state.user));
      }
    });

    on<RegisterWithFacebookPressed>((event, emit) async {
      try {
        final authService = AuthenticationService();
        final userCredential = await authService.registerWithFacebook();

        if (userCredential != null) {
          emit(RegisterProceed(state.user));
        }
      } on FirebaseAuthException catch (authError) {
        if (authError.code == 'email-already-in-use') {
          emit(RegisterFailure(
              error: event.localizations.already_have_account,
              user: state.user));
        }
      } catch (error) {
        emit(RegisterFailure(
            error: event.localizations.unknown_error, user: state.user));
      }
    });
  }
}
