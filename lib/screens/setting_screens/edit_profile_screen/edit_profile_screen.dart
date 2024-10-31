import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zpi_project/styles/layouts.dart';
import 'package:zpi_project/utils/check_login_status.dart';
import 'package:zpi_project/utils/const.dart';
import 'package:zpi_project/widgets/custom_dropdown.dart';
import 'package:zpi_project/widgets/profile_picture.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'edit_profile_bloc.dart';
import '../../../database_configuration/authentication_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late String _selectedCountry;

  late String _initialUsername;
  late String _initialEmail;
  late String _initialCountry;

  Timer? _debounce;
  final AuthenticationService authService = AuthenticationService();

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

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> sendPasswordResetEmail() async {
    try {
      await authService.sendPasswordResetEmail(email: _emailController.text);
      showSnackBar("Sprawdź skrzynkę pocztową aby zmienić hasło");
    } catch (e) {
      showSnackBar("Nie udało się wysłać emaila");
    }
  }

  void _checkUsernameAvailability() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 1), () {
      context.read<EditProfileBloc>().add(CheckUsernameAvailability(_usernameController.text));
    });
  }

  void onSaveChangesPressed() {
    final bloc = context.read<EditProfileBloc>();
    bloc.add(SaveProfileChanges());
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return MainLayout(
      child: Scaffold(
        appBar: CustomAppBar(text: localizations.edit_profile_title),
        body: BlocListener<EditProfileBloc, EditProfileState>(
          listener: (context, state) {
            if (state is EditProfileError) {
              // Display error messages and reset the state to ensure visibility each time
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.message),
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
              _initialEmail = state.user.email;
              _initialCountry = state.user.country;

              _usernameController.text = _initialUsername;
              _emailController.text = _initialEmail;
              _selectedCountry = _initialCountry;
            }
          },
          child: BlocBuilder<EditProfileBloc, EditProfileState>(
            builder: (context, state) {
              if (state is EditProfileLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
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
                        onChanged: (username) {
                          _checkUsernameAvailability();
                        },
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
                        text: Text("Reset password"),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
