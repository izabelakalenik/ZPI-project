import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final localizations = event.localizations;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: event.email);
      emit(ForgottenPasswordSuccess());
    } catch (error) {
      //emit(ForgottenPasswordFailure(error: error.toString()));
      emit(ForgottenPasswordFailure(error: localizations.send_email_error));
    }
  }
}
