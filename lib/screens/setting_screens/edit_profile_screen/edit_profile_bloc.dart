import '../../../database_configuration/authentication_service.dart';
import '../../../database_configuration/firestore_service.dart';
import '../../../models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final FirestoreService firestoreService = FirestoreService();
  final AuthenticationService authService = AuthenticationService();

  late UserModel initialUser; // Store initial user data in the bloc

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
        initialUser = await firestoreService.fetchUser(currentUser.uid); // Set initial user
        emit(EditProfileLoaded(initialUser, initialUser));
      } else {
        emit(EditProfileError("User not found.", UserModel.defaultConstructor()));
      }
    } catch (e) {
      emit(EditProfileError("Failed to load user profile.", UserModel.defaultConstructor()));
    }
  }

  void _onUpdateUsername(UpdateUsername event, Emitter<EditProfileState> emit) async {
    if (state is EditProfileLoaded) {
      final currentUsername = (state as EditProfileLoaded).user.username;
      if (event.username != currentUsername) {
        final isUnique = await firestoreService.isUsernameUnique(event.username);
        if (!isUnique) {
          emit(EditProfileError("Username taken", state.user));
        } else {
          final user = (state as EditProfileLoaded).user.copyWith(username: event.username);
          emit(EditProfileLoaded(user, initialUser));
        }
      } else {
        emit(EditProfileLoaded((state as EditProfileLoaded).user, initialUser));
      }
    }
  }

  void _onUpdatePassword(UpdatePassword event, Emitter<EditProfileState> emit) {
    if (state is EditProfileLoaded) {
      final user = (state as EditProfileLoaded).user.copyWith(password: event.password);
      emit(EditProfileLoaded(user, initialUser));
    }
  }

  void _onUpdateCountry(UpdateCountry event, Emitter<EditProfileState> emit) {
    if (state is EditProfileLoaded) {
      final user = (state as EditProfileLoaded).user.copyWith(country: event.country);
      emit(EditProfileLoaded(user,initialUser));
    }
  }

  Future<void> _onSaveProfileChanges(SaveProfileChanges event, Emitter<EditProfileState> emit) async {
    if (state is EditProfileLoaded) {
      final user = (state as EditProfileLoaded).user;

      if (user == initialUser) {
        return;
      }
      emit(EditProfileLoading());
      try {
        await firestoreService.saveUser(user, authService.getCurrentUser()!.uid);
        emit(EditProfileSuccess(user));
      } catch (e) {
        emit(EditProfileError("Failed to save profile changes: ${e.toString()}", user));
      }
    }
  }

  void _onCheckUsernameAvailability(CheckUsernameAvailability event, Emitter<EditProfileState> emit) async {
    final isUnique = await firestoreService.isUsernameUnique(event.username);
    if (!isUnique) {
      emit(EditProfileError("Username taken", state.user));
    }
  }
}
