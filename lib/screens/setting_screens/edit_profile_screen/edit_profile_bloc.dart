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
    on<UpdateEmail>(_onUpdateEmail);
    on<UpdatePassword>(_onUpdatePassword);
    on<UpdateCountry>(_onUpdateCountry);
    on<SaveProfileChanges>(_onSaveProfileChanges);
  }

  Future<void> _onLoadUserProfile(LoadUserProfile event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoading());
    try {
      final currentUser = authService.getCurrentUser();
      if (currentUser != null) {
        final user = await firestoreService.fetchUser(currentUser.uid);
        emit(EditProfileLoaded(user));
      } else {
        emit(EditProfileError("User not found."));
      }
    } catch (e) {
      emit(EditProfileError("Failed to load user profile."));
    }
  }

  void _onUpdateUsername(UpdateUsername event, Emitter<EditProfileState> emit) {
    if (state is EditProfileLoaded) {
      final user = (state as EditProfileLoaded).user.copyWith(username: event.username);
      emit(EditProfileLoaded(user));
    }
  }

  void _onUpdateEmail(UpdateEmail event, Emitter<EditProfileState> emit) {
    if (state is EditProfileLoaded) {
      final user = (state as EditProfileLoaded).user.copyWith(email: event.email);
      emit(EditProfileLoaded(user));
    }
  }

  void _onUpdatePassword(UpdatePassword event, Emitter<EditProfileState> emit) {
    if (state is EditProfileLoaded) {
      final user = (state as EditProfileLoaded).user.copyWith(password: event.password);
      emit(EditProfileLoaded(user));
    }
  }

  void _onUpdateCountry(UpdateCountry event, Emitter<EditProfileState> emit) {
    if (state is EditProfileLoaded) {
      final user = (state as EditProfileLoaded).user.copyWith(country: event.country);
      emit(EditProfileLoaded(user));
    }
  }

  Future<void> _onSaveProfileChanges(SaveProfileChanges event, Emitter<EditProfileState> emit) async {
    if (state is EditProfileLoaded) {
      final user = (state as EditProfileLoaded).user;
      emit(EditProfileLoading());
      try {
        await firestoreService.saveUser(user, authService.getCurrentUser()!.uid);
        emit(EditProfileLoaded(user));
      } catch (e) {
        emit(EditProfileError("Failed to save profile changes: ${e.toString()}"));
      }
    }
  }

}
