import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial());

  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterButtonPressed) {
      yield RegisterLoading();

      try {
        // Replace this with your own login logic
        await Future.delayed(const Duration(seconds: 2));
        yield RegisterSuccess();
      } catch (error) {
        yield RegisterFailure(error: error.toString());
      }
    }
  }
}