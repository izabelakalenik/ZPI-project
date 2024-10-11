import 'package:flutter/material.dart';
import 'package:zpi_project/styles/layouts.dart';
import 'package:zpi_project/utils/user_data.dart';
import 'package:zpi_project/widgets/profile_picture.dart';

import '../../models/user.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  // simulates getting data from database
  User user = UserData.myUser;

  TextEditingController? _passwordController;
  TextEditingController? _emailController;
  TextEditingController? _usernameController;

  late String _selectedCountry;
  bool _obscurePassword = true;
  // this should be read from API
  final List<String> _countries = ['Poland', 'France', 'Germany', 'Croatia', 'Spain', 'Italy', 'Ukriane'];

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController(text: user.password);
    _passwordController?.addListener(() {
      _passwordController == null ? "" : _passwordController!.text;
    });
    setState(() {});
    _emailController = TextEditingController(text: user.email);
    _emailController?.addListener(() {
      _emailController == null ? "" : _emailController!.text;
    });
    setState(() {});
    _usernameController = TextEditingController(text: user.username);
    _usernameController?.addListener(() {
      _usernameController == null ? "" : _usernameController!.text;
    });
    _selectedCountry = (user.country ?? "");
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController?.dispose();
    _emailController?.dispose();
    _usernameController?.dispose();
  }

  void onSaveChangesPressed() {
    // simulates saving data to database
    user.password = _passwordController!.text;
    user.email = _emailController!.text;
    user.username = _usernameController!.text;
    user.country = _selectedCountry;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MainLayout(
        child: Scaffold(
      appBar: CustomAppBar(text: 'Edit profile'),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 50),
          ProfilePicture(),
          const SizedBox(height: 24),
          CustomTextField(
            // initialValue: user.username,
            labelText: 'Username',
            controller: _usernameController,
          ),
          const SizedBox(height: 24),
          CustomTextField(
            labelText: 'Email',
            // initialValue: user.email,
            controller: _emailController,
          ),
          const SizedBox(height: 24),
          CustomTextField(
            labelText: 'Password',
            // initialValue: user.password,
            obscureText: _obscurePassword,
            controller: _passwordController,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: theme.iconTheme.color,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          const SizedBox(height: 24),
          // TODO: extract it to layouts
          DropdownButtonFormField<String>(
            style: TextStyle(color: Colors.white),
            iconEnabledColor: Colors.white,
            dropdownColor: Color(0xFFCF3F7B).withOpacity(0.9),
            menuMaxHeight: 200,
            value: user.country,
            onChanged: (String? value) {
              setState(() {
                _selectedCountry = value!;
              });
            },
            decoration: InputDecoration(
              labelText: 'Country',
              labelStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide:
                    const BorderSide(color: Colors.white70), // Gray border
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: const BorderSide(
                    color: Colors.white70),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: const BorderSide(
                    color: Colors.white70),
              ),
            ),
            items: _countries.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    Text(value),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Button(
              text: const Text("Save changes"), onPressed: onSaveChangesPressed)
        ],
      ),
    ));
  }
}
