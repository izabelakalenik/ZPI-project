import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zpi_project/screens/register_screen/second_register_screen.dart';
import 'package:zpi_project/styles/layouts.dart';
import '../login_screen/login_bloc.dart';
import '../login_screen/login_screen.dart';
import 'register_bloc.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _navigateToLoginScreen() {
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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerBloc = BlocProvider.of<RegisterBloc>(context);
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

    return MainLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterFailure) {
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
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(localizations.register, style: theme.textTheme.headlineLarge),
                    const SizedBox(height: 30),
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
                    const SizedBox(height: 20),
                    Text(localizations.or, style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 20),
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
                          _obscurePassword ? Icons.visibility_off : Icons
                              .visibility,
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
                    Button(
                      text: Text(localizations.next),
                      onPressed: state is! RegisterLoading
                          ? () {
                        registerBloc.add(
                          RegisterButtonPressed(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => RegisterBloc(),
                              child: const SecondRegisterScreen(),
                            ),
                          ),
                        );
                      }
                          : null,
                    ),
                    if (state is RegisterLoading)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    const SizedBox(height: 16),
                    // Forgot Password and Login Button
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: _navigateToLoginScreen,
                        child: Text(
                          localizations.already_have_account,
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