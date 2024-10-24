// import 'package:cloud_firestore/cloud_firestore.dart'; //Uncomment for tests
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zpi_project/screens/register_screen/register_bloc.dart';
import 'firebase_options.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //addData(); //For testing the connection with database (instances are added to the Firestore Database)
  runApp(
    BlocProvider(
      create: (context) => RegisterBloc(),
      child: App(),
    ),
  );
}

// void addData() {
//   FirebaseFirestore.instance.collection('test').add({'name': 'Test Item'});
// }

