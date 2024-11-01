part of 'edit_profile_bloc.dart';

abstract class EditProfileState {
  final UserModel user;
  EditProfileState(this.user);
}

class EditProfileInitial extends EditProfileState {
  EditProfileInitial() : super(UserModel.defaultConstructor());
}

class EditProfileLoading extends EditProfileState {
  EditProfileLoading() : super(UserModel.defaultConstructor());
}

class EditProfileLoaded extends EditProfileState {
  EditProfileLoaded(super.user);
}

class EditProfileProgress extends EditProfileState {
  EditProfileProgress(super.user);
}

class EditProfileError extends EditProfileState {
  final String message;
  EditProfileError(this.message, super.user);
}

class EditProfileSuccess extends EditProfileState {
  EditProfileSuccess(super.user);
}