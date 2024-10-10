import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zpi_project/screens/register_screen/categories_choice_screen.dart';
import 'package:zpi_project/styles/layouts.dart';
import 'register_bloc.dart';
import 'package:intl/intl.dart';

class SecondRegisterScreen extends StatefulWidget {
  const SecondRegisterScreen({super.key});

  @override
  State<SecondRegisterScreen> createState() => _SecondRegisterScreenState();
}

class _SecondRegisterScreenState extends State<SecondRegisterScreen> {
  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  String? _selectedOption;
  final List<String> _options = ['cats', 'dogs'];

  @override
  void dispose() {
    _nameController.dispose();
    _nicknameController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dateOfBirthController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
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
                    Text('Tell us more about you!', style: theme.textTheme.headlineLarge, textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    // Name Field
                    CustomTextField(
                      controller: _nameController,
                      labelText: 'Name',
                    ),
                    const SizedBox(height: 16),
                    // Username Field
                    CustomTextField(
                      controller: _nicknameController,
                      labelText: 'Username',
                    ),
                    const SizedBox(height: 16),
                    // Date of Birth Field
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _dateOfBirthController,
                            labelText: 'Date of Birth',
                            hintText: 'dd/MM/yyyy',
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                color: Colors.white.withOpacity(0.9),
                                onPressed: () {
                                  _selectDate(context);
                                },
                              ),
                            ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedOption,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelText: 'Cats Or Dogs?',
                                labelStyle: const TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: const BorderSide(color: Colors.white70), // Gray border on focus
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: const BorderSide(color: Colors.white70), // Gray border when enabled
                              ),
                            ),
                            dropdownColor: Color(0xFFC96786).withOpacity(0.9),
                            items: _options.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedOption = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Button(
                      text: const Text('Next'),
                      onPressed: state is! RegisterLoading
                          ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => RegisterBloc(),
                              child: const FavCategoriesScreen(),
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
