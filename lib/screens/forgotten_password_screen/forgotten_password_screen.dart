import 'package:flutter/material.dart';
import 'package:zpi_project/styles/layouts.dart';
import 'package:zpi_project/screens/forgotten_password_screen/forgotten_password_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgottenPasswordScreen extends StatefulWidget {
  const ForgottenPasswordScreen({super.key});

  @override
  State<ForgottenPasswordScreen> createState() => _ForgottenPasswordScreen();
}

class _ForgottenPasswordScreen extends State<ForgottenPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: ForgottenPasswordScreenContent(),
    );
  }
}

class ForgottenPasswordScreenContent extends StatelessWidget {
  final _emailController = TextEditingController();

  ForgottenPasswordScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final forgottenPasswordBloc =
        BlocProvider.of<ForgottenPasswordBloc>(context);
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: BlocListener<ForgottenPasswordBloc, ForgottenPasswordState>(
        listener: (context, state) {
          if (state is ForgottenPasswordFailure) {
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
        child: BlocBuilder<ForgottenPasswordBloc, ForgottenPasswordState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    localizations.forgot_password,
                    style: theme.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    localizations.forgotten_password_message,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  // Email Field
                  CustomTextField(
                    controller: _emailController,
                    labelText: localizations.email,
                  ),
                  const SizedBox(height: 16),
                  Button(
                    text: Text(localizations.send),
                    onPressed: state is! ForgottenPasswordLoading
                        ? () {
                            forgottenPasswordBloc.add(
                              SendButtonPressed(
                                  email: _emailController.text,
                                  localizations: localizations),
                            );
                          }
                        : null,
                  ),
                  if (state is ForgottenPasswordLoading)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  if (state
                      is ForgottenPasswordSuccess) // Display success message
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Text(
                        localizations.email_send_message,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
