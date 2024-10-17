import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zpi_project/screens/register_screen/categories_choice_screen.dart';
import 'package:zpi_project/styles/layouts.dart';
import 'register_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SecondRegisterScreen extends StatefulWidget {
  const SecondRegisterScreen({super.key});

  @override
  State<SecondRegisterScreen> createState() => _SecondRegisterScreenState();
}

class _SecondRegisterScreenState extends State<SecondRegisterScreen> {
  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _yearOfBirthController = TextEditingController();

  int? _selectedYear;
  String? _selectedOption;

  @override
  void dispose() {
    _nameController.dispose();
    _nicknameController.dispose();
    _yearOfBirthController.dispose();
    super.dispose();
  }

  Future<void> _selectYear(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(now.year - 100);
    final DateTime lastDate = DateTime(now.year);
    final localizations = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(localizations.select_year),
          content: SizedBox(
            height: 250,
            width: 300,
            child: YearPicker(
              firstDate: firstDate,
              lastDate: lastDate,
              selectedDate: _selectedYear != null ? DateTime(_selectedYear!) : now,
              onChanged: (DateTime selectedDate) {
                setState(() {
                  _selectedYear = selectedDate.year;
                  _yearOfBirthController.text = _selectedYear.toString();
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    final List<String> genderOptions = [
      localizations.female,
      localizations.male,
      localizations.other,
      localizations.prefer_not_to_say
    ];

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
                    Text(localizations.more_about_you, style: theme.textTheme.headlineLarge, textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    // Name Field
                    CustomTextField(
                      controller: _nameController,
                      labelText: localizations.name,
                    ),
                    const SizedBox(height: 16),
                    // Username Field
                    CustomTextField(
                      controller: _nicknameController,
                      labelText: localizations.username,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _yearOfBirthController,
                            labelText: localizations.year,
                            hintText: localizations.year_format,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              color: Colors.white.withOpacity(0.9),
                              onPressed: () {
                                _selectYear(context);
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
                                labelText: localizations.gender,
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
                            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                            items: genderOptions.map((String value) {
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
                    CustomButton(
                      text: Text(localizations.next),
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
