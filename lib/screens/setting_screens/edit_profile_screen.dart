import 'package:flutter/material.dart';
import 'package:zpi_project/styles/layouts.dart';
import 'package:zpi_project/utils/user_data.dart';
import 'package:zpi_project/utils/const.dart';
import 'package:zpi_project/widgets/password_field.dart';
import 'package:zpi_project/widgets/profile_picture.dart';
import 'package:zpi_project/widgets/custom_dropdown.dart';

import '../../models/user.dart';

// Edit Profile Screen
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  User user = UserData.myUser;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late String _selectedCountry;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _passwordController = TextEditingController(text: user.password);
    _emailController = TextEditingController(text: user.email);
    _usernameController = TextEditingController(text: user.username);
    _selectedCountry =
        COUNTRIES.contains(user.country) ? user.country! : COUNTRIES.first;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void onSaveChangesPressed() {
    user.password = _passwordController.text;
    user.email = _emailController.text;
    user.username = _usernameController.text;
    user.country = _selectedCountry;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Scaffold(
        appBar: CustomAppBar(text: 'Edit profile'),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 50),
            ProfilePicture(),
            SizedBox(height: 24),
            CustomTextField(
              labelText: 'Username',
              controller: _usernameController,
            ),
            SizedBox(height: 24),
            CustomTextField(
              labelText: 'Email',
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
              labelText: 'Country',
              value: _selectedCountry.isNotEmpty ? _selectedCountry : null,
              items: COUNTRIES,
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value!;
                });
              },
            ),
            SizedBox(height: 24),
            Button(
              text: Text("Save changes"),
              onPressed: onSaveChangesPressed,
            ),
          ],
        ),
      ),
    );
  }
}
