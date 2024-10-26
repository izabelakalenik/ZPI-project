import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zpi_project/screens/register_screen/fav_categories_screen.dart';
import 'package:zpi_project/styles/layouts.dart';

import 'register_bloc.dart';

class SecondRegisterScreen extends StatefulWidget {
  const SecondRegisterScreen({super.key});

  @override
  State<SecondRegisterScreen> createState() => _SecondRegisterScreenState();
}

class _SecondRegisterScreenState extends State<SecondRegisterScreen> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _yearOfBirthController = TextEditingController();
  late RegisterBloc registerBloc;

  @override
  void initState() {
    super.initState();
    registerBloc = BlocProvider.of<RegisterBloc>(context);
  }

  int? _selectedYear;
  String? _selectedGender;

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
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
              selectedDate:
                  _selectedYear != null ? DateTime(_selectedYear!) : now,
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
        appBar: CustomAppBar(text: "", height: 35),
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
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(localizations.more_about_you,
                        style: theme.textTheme.headlineLarge,
                        textAlign: TextAlign.center),
                    const SizedBox(height: 14),
                    // Name Field
                    CustomTextField(
                      controller: _nameController,
                      labelText: localizations.name,
                    ),
                    const SizedBox(height: 14),
                    // Username Field
                    CustomTextField(
                      controller: _usernameController,
                      labelText: localizations.username,
                    ),
                    const SizedBox(height: 14),
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
                        const SizedBox(width: 14),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedGender,
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
                                borderSide: const BorderSide(
                                    color:
                                        Colors.white70), // Gray border on focus
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: const BorderSide(
                                    color: Colors
                                        .white70), // Gray border when enabled
                              ),
                            ),
                            dropdownColor: Color(0xFFC96786).withOpacity(0.9),
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.white),
                            items: genderOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedGender = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Button(
                      text: Text(localizations.next),
                      onPressed: () {
                        // Dispatch EmailPasswordEntered event
                        registerBloc.add(
                          UserDetailsEntered(
                            name: _nameController.text,
                            username: _usernameController.text,
                            birthYear: int.parse(_yearOfBirthController.text),
                            country: "Poland",
                            gender: _selectedGender == null ? "" : _selectedGender! ,
                          ),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: registerBloc,
                              child: const FavCategoriesScreen(),
                            ),
                          ),
                        );
                      },
                    ),
                    //if (state is RegisterLoading)
                    //  const Padding(
                    //    padding: EdgeInsets.all(8.0),
                    //   child: CircularProgressIndicator(),
                    //  ),
                    const SizedBox(height: 14),
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
