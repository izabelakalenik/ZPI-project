import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database_configuration/authentication_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationService authService;

  RegisterBloc(this.authService) : super(RegisterInitial()) {
    on<EmailPasswordEntered>((event, emit) async {
      final isUnique = await authService.isEmailUnique(event.email);
      if (!isUnique) {
        emit(RegisterFailure(error: 'Email is already in use.'));
      } else {
        emit(RegisterProceedToSecondScreen(email: event.email, password: event.password));
      }
    });

    on<UserDetailsEntered>((event, emit) async{
      final isUnique = await authService.isUsernameUnique(event.username);
      if (!isUnique) {
        emit(RegisterFailure(error: 'Username is already in use.'));
      } else {
          emit(RegisterProceedToFavGenresScreen(
          email: state.email,
          password: state.password,
          name: event.name,
          username: event.username,
          birthYear: event.birthYear,
          country: "Poland",
          gender: event.gender,));
      }
    });

    on<GenresSelected>((event, emit) {
      emit(state.copyWith(genres: event.genres));
    });

    on<SubmitRegistration>((event, emit) async {
      try {
        await authService.registerUser(state.email, state.password, state.name, state.username, state.birthYear,state.gender, state.country, state.genres );
        emit(RegisterInitial()); // Reset state
      } catch (error) {
        // Handle error emit(RegisterFailure(error: 'Registration failed. Please try again.'));
      }
    });

  }
}