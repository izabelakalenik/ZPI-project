import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:zpi_project/screens/forgotten_password_screen/forgotten_password_bloc.dart';
import 'package:zpi_project/screens/forgotten_password_screen/forgotten_password_screen.dart';
import 'package:zpi_project/screens/home_screen.dart';
import 'package:zpi_project/styles/layouts.dart';

import '../register_screen/register_bloc.dart';
import '../register_screen/register_screen.dart';
import 'login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _navigateToRegisterScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => RegisterBloc(),
          child: const RegisterScreen(),
        ),
      ),
    );
  }

  void _navigateToForgottenPasswordScreen() {
    //edit this
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => ForgottenPasswordBloc(),
          child: const ForgottenPasswordScreen(),
        ),
      ),
    );
  }

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
    final localizations = AppLocalizations.of(context);

    return MainLayout(
      child: Scaffold(
        appBar: CustomAppBar(text: ""),
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
            } else if (state is LoginSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            }
          },
        child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(localizations.login_2,
                        style: theme.textTheme.headlineLarge),
                    const SizedBox(height: 16),
                    // Social Login Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomSocialLoginButton(
                            text: localizations.google,
                            buttonType: SocialLoginButtonType.google,
                            onPressed: () async {
                              // await socialAuthProvider.handleGoogleSignIn();
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomSocialLoginButton(
                            text: localizations.facebook,
                            buttonType: SocialLoginButtonType.facebook,
                            onPressed: () async {
                              // await socialAuthProvider.handleGoogleSignIn();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(localizations.or, style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 16),
                    // Email Field
                    CustomTextField(
                      controller: _emailController,
                      labelText: localizations.email,
                    ),
                    const SizedBox(height: 16),
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
                    // Forgot Password and Login Button
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: _navigateToForgottenPasswordScreen,
                        child: Text(
                          localizations.forgot_password,
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Button(
                      text: Text(localizations.login_2),
                      onPressed: state is! LoginLoading
                          ? () {
                        final email = _emailController.text;
                        final password = _passwordController.text;

                        if (email.isNotEmpty && password.isNotEmpty) {
                          loginBloc.add(LoginButtonPressed(
                            email: email,
                            password: password,
                            localizations: localizations
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(localizations.fill_both))
                          );
                        }
                      }
                          : null,
                    ),
                    if (state is LoginLoading)
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: CircularProgressIndicator(),
                      ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: _navigateToRegisterScreen,
                        child: Text(
                          localizations.dont_have_an_account,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                          ),
                        ),
                      ),
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
