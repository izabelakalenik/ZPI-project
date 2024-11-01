import '../../../database_configuration/authentication_service.dart';
import '../../../database_configuration/firestore_service.dart';
import '../../../models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final FirestoreService firestoreService = FirestoreService();
  final AuthenticationService authService = AuthenticationService();

  EditProfileBloc() : super(EditProfileInitial()) {
    on<LoadUserProfile>(_onLoadUserProfile);
    on<UpdateUsername>(_onUpdateUsername);
    on<UpdatePassword>(_onUpdatePassword);
    on<UpdateCountry>(_onUpdateCountry);
    on<SaveProfileChanges>(_onSaveProfileChanges);
    on<CheckUsernameAvailability>(_onCheckUsernameAvailability);
  }

  Future<void> _onLoadUserProfile(LoadUserProfile event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoading());
    try {
      final currentUser = authService.getCurrentUser();
      if (currentUser != null) {
        final user = await firestoreService.fetchUser(currentUser.uid);
        emit(EditProfileLoaded(user));
      } else {
        emit(EditProfileError("user-not-found",UserModel.defaultConstructor()));
      }
    } catch (e) {
      emit(EditProfileError("load-user-fail.",UserModel.defaultConstructor()));
    }
  }

  void _onUpdateUsername(UpdateUsername event, Emitter<EditProfileState> emit) {
    if (state is! EditProfileLoading ) {
      final user = state.user.copyWith(username: event.username);
      emit(EditProfileProgress(user));
    }
  }

  void _onUpdatePassword(UpdatePassword event, Emitter<EditProfileState> emit) {
    if (state is! EditProfileLoading ) {
      final user = state.user.copyWith(password: event.password);
      emit(EditProfileProgress(user));
    }
  }

  void _onUpdateCountry(UpdateCountry event, Emitter<EditProfileState> emit) {
    if (state is! EditProfileLoading ) {
      final user = state.user.copyWith(country: event.country);
      emit(EditProfileProgress(user));
    }
  }


  Future<void> _onSaveProfileChanges(SaveProfileChanges event, Emitter<EditProfileState> emit) async {
    if(state is! EditProfileLoading ){
      final user = state.user;

      final isUnique = await firestoreService.isUsernameUnique(event.username);
      if (!isUnique && event.username != user.username) {
        emit(EditProfileError("username-taken", user));
        return;
      }
      final updatedUser = user.copyWith(username: event.username, country: user.country);
      emit(EditProfileLoading());

      try {
        await firestoreService.saveUser(updatedUser, authService.getCurrentUser()!.uid);
        emit(EditProfileSuccess(updatedUser));
        emit(EditProfileLoaded(updatedUser));
      } catch (e) {
        emit(EditProfileError("save-changes-unknown}", updatedUser));
      }
    }
  }

  void _onCheckUsernameAvailability(CheckUsernameAvailability event, Emitter<EditProfileState> emit) async {
    final isUnique = await firestoreService.isUsernameUnique(event.username);

    if (!isUnique && event.username != state.user.username) {
      emit(EditProfileError("username-taken",state.user));
    } else if (event.username.isNotEmpty) {
      final updatedUser = state.user.copyWith(username: event.username);
      emit(EditProfileProgress(updatedUser));
    }
  }
}