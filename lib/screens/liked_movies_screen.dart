import 'package:flutter/material.dart';
import 'package:zpi_project/screens/shake_movie_screen.dart';
import 'package:zpi_project/styles/layouts.dart';
import 'package:zpi_project/widgets/movie_card/movie_card_model.dart';

import '../widgets/nav_drawer.dart';

// this is a simplified version of the LikedMoviesScreen
// it was created just to maintain flow between screens
class LikedMoviesScreen extends StatelessWidget {
  const LikedMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        child: Scaffold(
            drawer: NavDrawer(),
            appBar: CustomAppBar(text: "Liked movies"),
            // im not extracting it since this whole screen will be changed
            body: Center(
              child: Button(
                text: Text("go shake"),
                // im not extracting it since this whole screen will be changed
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ShakeMovieScreen(likedMovies: movies),
                    ),
                  );
                },
              ),
            )));
  }
}
