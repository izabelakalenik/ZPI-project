part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent {}

class LoadUserProfile extends EditProfileEvent {}

class UpdateUsername extends EditProfileEvent {
  final String username;
  UpdateUsername(this.username);
}

class UpdateEmail extends EditProfileEvent {
  final String email;
  UpdateEmail(this.email);
}

class UpdatePassword extends EditProfileEvent {
  final String password;
  UpdatePassword(this.password);
}

class UpdateCountry extends EditProfileEvent {
  final String country;
  UpdateCountry(this.country);
}

class SaveProfileChanges extends EditProfileEvent {}
