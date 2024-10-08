import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zpi_project/styles/layouts.dart';
import 'login_bloc.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    final theme = Theme.of(context);

    return MainLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
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
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.login_2,
                        style: theme.textTheme.headlineLarge),
                    const SizedBox(height: 30),
                    // Social Login Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SocialLoginButton(
                            text: AppLocalizations.of(context)!.google,
                            textColor: Colors.white,
                            backgroundColor: Colors.black.withOpacity(0.2),
                            buttonType: SocialLoginButtonType.google,
                            imageWidth: 20,
                            borderRadius: 15,
                            onPressed: () async {
                              // await socialAuthProvider.handleGoogleSignIn();
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SocialLoginButton(
                            text: AppLocalizations.of(context)!.facebook,
                            textColor: Colors.white,
                            backgroundColor: Colors.black.withOpacity(0.2),
                            imageWidth: 20,
                            buttonType: SocialLoginButtonType.facebook,
                            borderRadius: 15,
                            onPressed: () async {
                              // await socialAuthProvider.handleGoogleSignIn();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(AppLocalizations.of(context)!.or,
                        style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 20),
                    // Email Field
                    CustomTextField(
                      controller: _emailController,
                      labelText: AppLocalizations.of(context)!.email,
                    ),
                    const SizedBox(height: 16),
                    // Password Field
                    CustomTextField(
                      controller: _passwordController,
                      labelText: AppLocalizations.of(context)!.password,
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
                    // Forgot Password and Login Button
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.forgot_password,
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Button(
                      text: Text(AppLocalizations.of(context)!.login_2),
                      onPressed: state is! LoginLoading
                          ? () {
                              loginBloc.add(
                                LoginButtonPressed(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                            }
                          : null,
                    ),
                    if (state is LoginLoading)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    const SizedBox(height: 20),
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
