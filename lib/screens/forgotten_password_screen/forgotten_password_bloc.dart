import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgotten_password_event.dart';
part 'forgotten_password_state.dart';

class ForgottenPasswordBloc
    extends Bloc<ForgottenPasswordEvent, ForgottenPasswordState> {
  ForgottenPasswordBloc() : super(ForgottenPasswordInitial()) {
    on<SendButtonPressed>(_onSendButtonPressed);
  }

  Future<void> _onSendButtonPressed(
    SendButtonPressed event,
    Emitter<ForgottenPasswordState> emit,
  ) async {
    emit(ForgottenPasswordLoading());

    try {
      // Replace this with your own sending email logic
      await Future.delayed(const Duration(seconds: 2));
      emit(ForgottenPasswordSuccess());
    } catch (error) {
      emit(ForgottenPasswordFailure(error: error.toString()));
    }
  }
}
