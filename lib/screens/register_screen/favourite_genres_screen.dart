import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:zpi_project/screens/register_screen/register_bloc.dart';
import 'package:zpi_project/screens/register_screen/welcome_screen.dart';
import 'package:zpi_project/styles/layouts.dart';

import '../../movies/data/repositories/movie_repository_impl.dart';

class FavouriteGenresScreen extends StatefulWidget {
  const FavouriteGenresScreen({super.key});

  @override
  State<FavouriteGenresScreen> createState() => _FavouriteGenresScreenState();
}

class _FavouriteGenresScreenState extends State<FavouriteGenresScreen> {
  late RegisterBloc registerBloc;
  late MovieRepositoryImpl movieRepository;
  Map<int, String> _genres = {};

  @override
  void initState() {
    super.initState();
    registerBloc = BlocProvider.of<RegisterBloc>(context);
    movieRepository = Provider.of<MovieRepositoryImpl>(context, listen: false);
    _loadGenres(); // Load genres when initializing
  }

  Future<void> _loadGenres() async {
    final genreMap =
        await movieRepository.getRealTimeGenres(); // Fetch genres map
    setState(() {
      _genres = genreMap; // Convert map values to list
    });
  }

  final List<int> _selectedGenres = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

    return MainLayout(
      child: Scaffold(
        appBar: CustomAppBar(text: "", height: 35),
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
              _buildGenreSelection(),
              const SizedBox(height: 20),
              _buildSubmitButton(localizations),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenreSelection() {
    return SizedBox(
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
            final genreEntry = _genres.entries.elementAt(index);
            final genreId = genreEntry.key;
            final genreName = genreEntry.value;

            return CheckboxListTile(
              side: BorderSide(color: Colors.white),
              checkColor: Colors.white,
              fillColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Color(0xFF91007E);
                  }
                  return Colors.white;
                },
              ),
              value: _selectedGenres.contains(genreId),
              onChanged: (isChecked) {
                setState(() {
                  if (isChecked!) {
                    _selectedGenres.add(genreId);
                  } else {
                    _selectedGenres.remove(genreId);
                  }
                });
              },
              title: Text(
                genreName,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSubmitButton(AppLocalizations localizations) {
    return Button(
      width: 220,
      text: Text(localizations.create, textAlign: TextAlign.center),
      onPressed: _selectedGenres.isNotEmpty
          ? () {
              registerBloc.add(
                GenresSelected(
                  genres: _selectedGenres,
                  localizations: localizations,
                ),
              );
              registerBloc.add(
                SubmitRegistration(localizations: localizations),
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomeScreen(),
                ),
                (Route<dynamic> route) => route.isFirst,
              );
            }
          : null, // The button is disabled if nothing is chosen
    );
  }
}
