import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zpi_project/styles/layouts.dart';
import 'package:zpi_project/utils/check_login_status.dart';
import 'package:zpi_project/utils/const.dart';
import 'package:zpi_project/widgets/custom_dropdown.dart';
import 'package:zpi_project/widgets/password_field.dart';
import 'package:zpi_project/widgets/profile_picture.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'edit_profile_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late String _selectedCountry;

  bool _obscurePassword = true;

  // Store initial values
  late String _initialUsername;
  late String _initialEmail;
  late String _initialPassword;
  late String _initialCountry;

  @override
  void initState() {
    super.initState();
    checkLoginStatus(context);

    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _selectedCountry = COUNTRIES.first;

    final bloc = BlocProvider.of<EditProfileBloc>(context);
    bloc.add(LoadUserProfile());
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void onSaveChangesPressed() {
    final bloc = context.read<EditProfileBloc>();

    bool hasChanges = false;

    if (_usernameController.text != _initialUsername) {
      bloc.add(UpdateUsername(_usernameController.text));
      hasChanges = true;
    }
    if (_emailController.text != _initialEmail) {
      bloc.add(UpdateEmail(_emailController.text));
      hasChanges = true;
    }
    if (_passwordController.text != _initialPassword) {
      bloc.add(UpdatePassword(_passwordController.text));
      hasChanges = true;
    }
    if (_selectedCountry != _initialCountry) {
      bloc.add(UpdateCountry(_selectedCountry));
      hasChanges = true;
    }

    // Only save if there are changes
    if (hasChanges) {
      bloc.add(SaveProfileChanges());
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
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
              // Update initial values when profile is loaded
              _initialUsername = state.user.username;
              _initialEmail = state.user.email;
              _initialPassword = state.user.password;
              _initialCountry = state.user.country;

              // Set controllers' text
              _usernameController.text = _initialUsername;
              _emailController.text = _initialEmail;
              _passwordController.text = _initialPassword;
              _selectedCountry = _initialCountry;
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
                    ),
                    SizedBox(height: 24),
                    CustomTextField(
                      labelText: localizations.email,
                      controller: _emailController,
                    ),
                    SizedBox(height: 24),
                    PasswordField(
                      controller: _passwordController,
                      obscurePassword: _obscurePassword,
                      onToggle: _togglePasswordVisibility,
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
