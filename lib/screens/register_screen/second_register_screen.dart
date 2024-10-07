import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zpi_project/styles/layouts.dart';
import 'register_bloc.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class SecondRegisterScreen extends StatefulWidget {
  const SecondRegisterScreen({super.key});

  @override
  State<SecondRegisterScreen> createState() => _SecondRegisterScreenState();
}

class _SecondRegisterScreenState extends State<SecondRegisterScreen> {
  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<RegisterBloc>(context);
    final theme = Theme.of(context);

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
                    Text('Tell us more about you!', style: theme.textTheme.headlineLarge),
                    const SizedBox(height: 20),
                    Text('Or', style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 20),
                    // Email Field
                    CustomTextField(
                      controller: _nameController,
                      labelText: 'Name',
                    ),
                    const SizedBox(height: 16),
                    // Password Field
                    CustomTextField(
                      controller: _nicknameController,
                      labelText: 'Nickname',
                    ),
                    const SizedBox(height: 16),
                    Button(
                      text: const Text('Next'),
                      onPressed: state is! RegisterLoading
                          ? () {
                        // loginBloc.add(
                        //   RegisterButtonPressed(
                        //     name: _nameController.text,
                        //     nickname: _nicknameController.text,
                        //   ),
                        // );
                      }
                          : null,
                    ),
                    if (state is RegisterLoading)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Already have an account? Log in',
                        style: theme.textTheme.titleSmall,
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
