import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:zpi_project/screens/register_screen/register_event.dart';
import 'package:zpi_project/screens/register_screen/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    // Register event handlers
    on<RegisterWithEmailAndPassword>(_onRegisterWithEmailAndPassword);
    on<RegisterAdditionalInfo>(_onRegisterAdditionalInfo);
    on<RegisterFavoriteGenres>(_onRegisterFavoriteGenres);
  }

  // Event handler for RegisterWithEmailAndPassword
  Future<void> _onRegisterWithEmailAndPassword(
      RegisterWithEmailAndPassword event, Emitter<RegisterState> emit) async {
    emit(RegisterInProgress());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: event.email, password: event.password);

      String uid = userCredential.user!.uid;

      // Store additional user data in Firestore using the UID as the document ID
      //await FirebaseFirestore.instance.collection('users').doc(uid).set({
      //  'email': event.email,
      //  'createdAt': FieldValue.serverTimestamp(),
      //  // Add other fields as necessary
      //});

      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(error: e.toString()));
    }
  }


  // Event handler for RegisterAdditionalInfo
  Future<void> _onRegisterAdditionalInfo(

      RegisterAdditionalInfo event, Emitter<RegisterState> emit) async {
      emit(RegisterInProgress());
      try {
        User? currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser != null){
          await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set({
            'name': event.name,
            'username': event.username,
            'birthYear': event.birthYear,
            'gender': event.gender,
          });
        }


        emit(RegisterSuccess());
      } catch (e) {
      emit(RegisterFailure(error: e.toString()));
    }
  }

  // Event handler for RegisterFavoriteGenres
  Future<void> _onRegisterFavoriteGenres(
      RegisterFavoriteGenres event, Emitter<RegisterState> emit) async {
    emit(RegisterInProgress());
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .update({
          'favoriteGenres': event.favoriteGenres,
        });

        emit(RegisterSuccess());
      } else {
        emit(RegisterFailure(error: "User not logged in"));
      }
    } catch (e) {
      emit(RegisterFailure(error: e.toString()));
    }
  }
}
