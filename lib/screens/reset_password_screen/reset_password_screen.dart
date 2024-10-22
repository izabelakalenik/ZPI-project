import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:zpi_project/screens/login_screen/login_bloc.dart';
import 'package:zpi_project/screens/reset_password_screen/reset_password_bloc.dart';
import 'package:zpi_project/styles/layouts.dart';
import 'package:zpi_project/screens/login_screen/login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreen();
}

class _ResetPasswordScreen extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _passwordRepeatController = TextEditingController();
  bool _obscurePassword = true;

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => LoginBloc(),
          child: const LoginScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    return BlocProvider(
      create: (context) => ResetPasswordBloc(),
      child: Builder(builder: (context) {
        final resetPasswordBloc = BlocProvider.of<ResetPasswordBloc>(context);
        return MainLayout(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            body: BlocListener<ResetPasswordBloc, ResetPasswordState>(
              listener: (context, state) {
                if (state is ResetPasswordFailure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                }
              },
              child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(localizations.create_new_password,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineLarge),
                        const SizedBox(height: 40),
                        // Password Field
                        CustomTextField(
                          controller: _passwordController,
                          labelText: localizations.password,
                          obscureText: _obscurePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: theme.iconTheme.color,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword =
                                    !_obscurePassword; // Toggle password visibility
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Password Field
                        CustomTextField(
                          controller: _passwordRepeatController,
                          labelText: localizations.repeat_password,
                          obscureText: _obscurePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: theme.iconTheme.color,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword =
                                    !_obscurePassword; // Toggle password visibility
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        Button(
                          text: Text(localizations.create_txt),
                          onPressed: state is! ResetPasswordLoading
                              ? () {
                                  resetPasswordBloc.add(
                                    (ResetPasswordButtonPressed(
                                        password: _passwordController.text,
                                        repeatedPassword:
                                            _passwordRepeatController.text)),
                                  );
                                  _navigateToLogin();
                                }
                              : null,
                        ),
                        if (state is ResetPasswordLoading)
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
