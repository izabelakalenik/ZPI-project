import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database_configuration/authentication_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationService authService;

  RegisterBloc(this.authService) : super(RegisterState()) {
    on<EmailPasswordEntered>((event, emit) {
      emit(state.copyWith(email: event.email, password: event.password));
    });

    on<UserDetailsEntered>((event, emit) {
      emit(state.copyWith(
        name: event.name,
        username: event.username,
        birthYear: event.birthYear,
        country: "Poland",
        gender: event.gender,
      ));
    });

    on<GenresSelected>((event, emit) {
      emit(state.copyWith(genres: event.genres));
    });

    on<SubmitRegistration>((event, emit) async {
      try {
        await authService.registerUser(state.email, state.password, state.name, state.username, state.birthYear,state.gender, state.country, state.genres );
        emit(RegisterState()); // Reset state
      } catch (error) {
        // Handle error
      }
    });
  }
}