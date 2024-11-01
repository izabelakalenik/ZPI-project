import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zpi_project/styles/layouts.dart';
import 'package:zpi_project/utils/check_login_status.dart';
import 'package:zpi_project/utils/const.dart';
import 'package:zpi_project/widgets/custom_dropdown.dart';
import 'package:zpi_project/widgets/profile_picture.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../database_configuration/authentication_service.dart';
import 'edit_profile_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late String _selectedCountry;
  final AuthenticationService authService = AuthenticationService();
  late  AppLocalizations localizations;

  Timer? _debounce;

  late String _initialUsername;
  late String _initialCountry;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localizations = AppLocalizations.of(context);
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus(context);

    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _selectedCountry = COUNTRIES.first;

    final bloc = BlocProvider.of<EditProfileBloc>(context);
    bloc.add(LoadUserProfile());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _checkUsernameAvailability() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 1), () {
      final bloc = context.read<EditProfileBloc>();
      if (_usernameController.text != _initialUsername) {
        bloc.add(CheckUsernameAvailability(_usernameController.text.trim()));
      }
    });
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void onSaveChangesPressed() {
    final bloc = context.read<EditProfileBloc>();

    final hasUsernameChanged = _usernameController.text.trim() != _initialUsername.trim();
    final hasCountryChanged = _selectedCountry != _initialCountry;

    if (_usernameController.text.isEmpty) {
      showSnackBar(localizations.edit_profile_input_username);
      return;
    }
    if (!hasUsernameChanged && !hasCountryChanged) {return;}
    if (hasCountryChanged) {bloc.add(UpdateCountry(_selectedCountry));}

    bloc.add(SaveProfileChanges(_usernameController.text.trim()));
  }

  Future<void> sendPasswordResetEmail() async {
    try {
      await authService.sendPasswordResetEmail(email: _emailController.text);
      showSnackBar(localizations.email_send_message);
    } catch (e) {
      showSnackBar(localizations.send_email_error_unknown);
    }
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case "user-not-found":
        return localizations.edit_profile_user_not_found;
      case "load-user-fail":
        return localizations.edit_profile_load_user_fail;
      case "username-taken":
        return localizations.edit_profile_username_taken;
      case "save-changes-unknown":
        return localizations.edit_profile_save_changes_unknown;
      default:
        return localizations.edit_profile_unexpected_error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Scaffold(
        appBar: CustomAppBar(text: localizations.edit_profile_title),
        body: BlocListener<EditProfileBloc, EditProfileState>(
          listener: (context, state) {
            if (state is EditProfileError) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(_getErrorMessage(state.message)),
                    duration: const Duration(seconds: 3),
                  ),
                );
            } else if (state is EditProfileSuccess) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(localizations.edit_profile_changes_saved),
                    duration: const Duration(seconds: 3),
                  ),
                );
            } else if (state is EditProfileLoaded) {
              _initialUsername = state.user.username;
              _initialCountry = state.user.country;
            }
            if (state is EditProfileProgress ||  state is EditProfileLoaded){
              _usernameController.text = state.user.username;
              _emailController.text = state.user.email;
              _selectedCountry = state.user.country;
            }
          },
          child: BlocBuilder<EditProfileBloc, EditProfileState>(
            builder: (context, state) {
              if (state is EditProfileLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(height: 50),
                    ProfilePicture(),
                    SizedBox(height: 24),
                    CustomTextField(
                      labelText: localizations.username,
                      controller: _usernameController,
                      onChanged:(value) {_checkUsernameAvailability();},
                    ),
                    SizedBox(height: 24),
                    CustomTextField(
                      labelText: localizations.email,
                      controller: _emailController,
                      readOnly: true,
                    ),
                    SizedBox(height: 24),
                    CustomDropdown(
                      labelText: localizations.country,
                      value: _selectedCountry,
                      items: COUNTRIES,
                      onChanged: (value) {
                        setState(() {
                          _selectedCountry = value!;
                        });
                      },
                    ),
                    SizedBox(height: 24),
                    Button(
                      text: Text(localizations.edit_profile_save_changes),
                      onPressed: onSaveChangesPressed,
                    ),
                    SizedBox(height: 24),
                    Button(
                      onPressed: sendPasswordResetEmail,
                      text: Text(localizations.edit_profile_reset_password),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}