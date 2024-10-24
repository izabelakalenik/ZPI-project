import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zpi_project/screens/register_screen/register_bloc.dart';
import 'package:zpi_project/screens/register_screen/register_event.dart';
import 'package:zpi_project/screens/register_screen/welcome_screen.dart';
import 'package:zpi_project/styles/layouts.dart';

class FavCategoriesScreen extends StatefulWidget {
  const FavCategoriesScreen({super.key});

  @override
  State<FavCategoriesScreen> createState() => _FavCategoriesScreenState();
}

class _FavCategoriesScreenState extends State<FavCategoriesScreen> {
  final List<String> _genres = [
    'Romantic Comedy',
    'Adventure',
    'Horror',
    'Sci-fi',
    'Thriller',
    'Anime',
    'Drama'
  ];

  final List<String> _selectedGenres = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

    return MainLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                localizations.what_do_you_like,
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                localizations.choose,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 350,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.transparent, width: 0),
                  ),
                  child: ListView.builder(
                      itemCount: _genres.length,
                      itemBuilder: (context, index) {
                        final genre = _genres[index];
                        return CheckboxListTile(
                          side: BorderSide(color: Colors.white),
                          checkColor: Colors.white,
                          fillColor: WidgetStateProperty.resolveWith<Color>(
                              (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return Color(0xFF91007E);
                            }
                            return Colors.white;
                          }),
                          value: _selectedGenres.contains(genre),
                          onChanged: (isChecked) {
                            setState(() {
                              if (isChecked!) {
                                _selectedGenres.add(genre);
                              } else {
                                _selectedGenres.remove(genre);
                              }
                            });
                          },
                          title: Text(
                            genre,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }),
                ),
              ),
              const SizedBox(height: 20),
              Button(
                width: 200,
                text: Text(localizations.create, textAlign: TextAlign.center),
                onPressed: _selectedGenres.isNotEmpty
                    ? () {
                  BlocProvider.of<RegisterBloc>(context).add(
                    RegisterFavoriteGenres(favoriteGenres: _selectedGenres),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WelcomeScreen(),
                    ),
                  );
                }
                    : null,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
