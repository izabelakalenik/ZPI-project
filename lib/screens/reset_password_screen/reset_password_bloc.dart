import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordInitial()) {
    on<ResetPasswordButtonPressed>(_onResetPasswordButtonPressed);
  }

  Future<void> _onResetPasswordButtonPressed(
    ResetPasswordButtonPressed event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(ResetPasswordLoading());

    // chcecking if password match
    if (event.password != event.repeatedPassword) {
      emit(ResetPasswordFailure(error: "Password is repeated"));
      return;
    }

    try {
      // Replace this with your own reset password logic
      await Future.delayed(const Duration(seconds: 2)); // Symulacja operacji
      emit(ResetPasswordSuccess());
    } catch (error) {
      emit(ResetPasswordFailure(error: error.toString()));
    }
  }
}
