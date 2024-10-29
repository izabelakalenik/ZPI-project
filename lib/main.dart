// import 'package:cloud_firestore/cloud_firestore.dart'; //Uncomment for tests
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app.dart';
import 'package:zpi_project/movies/data/repositories/movie_repository_impl.dart';
import 'package:zpi_project/movies/data/data_sources/movie_remote_data_source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final movieRemoteDataSource = MovieRemoteDataSource();
  final movieRepository = MovieRepositoryImpl(movieRemoteDataSource);
  //addData(); //For testing the connection with database (instances are added to the Firestore Database)
  runApp(
    MultiProvider(
      providers: [
        Provider<MovieRepositoryImpl>(
          create: (_) => movieRepository,
        ),
      ],
      child: const App(),
    ),
  );
}

// void addData() {
//   FirebaseFirestore.instance.collection('test').add({'name': 'Test Item'});
// }

