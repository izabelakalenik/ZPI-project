import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../database_configuration/firestore_service.dart';

part 'joined_event.dart';
part 'joined_state.dart';

class JoinedInitial extends JoinedState {}

class JoinedRoomJoined extends JoinedState {
  final String roomCode;

  JoinedRoomJoined(this.roomCode);

  @override
  List<Object?> get props => [roomCode];
}

class JoinedParticipantsUpdated extends JoinedState {
  final List<String> friends;

  JoinedParticipantsUpdated(this.friends);

  @override
  List<Object?> get props => [friends];
}

// JoinedBloc
class JoinedBloc extends Bloc<JoinedEvent, JoinedState> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final FirestoreService firestoreService = FirestoreService();

  late DatabaseReference _participantsRef;

  JoinedBloc() : super(JoinedInitial()) {
    on<JoinRoom>(_onJoinRoom);
  }

  Future<void> _onJoinRoom(JoinRoom event, Emitter<JoinedState> emit) async {
    final roomRef = _database.child('rooms').child(event.roomCode);
    _participantsRef = roomRef.child('participants');
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final user = await firestoreService.fetchUser(currentUser.uid);

      _participantsRef.child(user.username);

    } else {
      _participantsRef.child("Anonymous");
    }

    _listenToParticipants(emit);

    emit(JoinedRoomJoined(event.roomCode));
  }

  void _listenToParticipants(Emitter<JoinedState> emit) {
    _participantsRef.onValue.listen((event) {
      final participantsSnapshot = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      final friends = participantsSnapshot.values.cast<String>().toList();
      emit(JoinedParticipantsUpdated(friends));
    });
  }
}
