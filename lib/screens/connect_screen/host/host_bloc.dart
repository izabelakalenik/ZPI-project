
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../database_configuration/firestore_service.dart';

part 'host_event.dart';
part 'host_state.dart';

class HostBloc extends Bloc<HostEvent, HostState> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final FirestoreService firestoreService = FirestoreService();

  late DatabaseReference _participantsRef;

  HostBloc() : super(HostInitial()) {
    on<CreateRoom>(_onCreateRoom);
    on<AddParticipant>(_onAddParticipant);
  }

  Future<void> _onCreateRoom(CreateRoom event, Emitter<HostState> emit) async {
    final roomCode = Uuid().v4().substring(0, 8);
    final roomRef = _database.child('rooms').child(roomCode);
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final user = await firestoreService.fetchUser(currentUser.uid);

      await roomRef.set({
        'host': user.username,
        'participants': {currentUser.uid: user.username}
      });
        } else {
      //error
    }

    _participantsRef = roomRef.child('participants');
    _listenToParticipants(emit);
    emit(HostRoomCreated(roomCode));
  }

  Future<void> _onAddParticipant(AddParticipant event, Emitter<HostState> emit) async {
    _participantsRef.child(event.participantId).set(event.participantName);
  }

  void _listenToParticipants(Emitter<HostState> emit) {
    _participantsRef.onValue.listen((event) {
      final participantsSnapshot = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      final friends = participantsSnapshot.values.cast<String>().toList();
      emit(HostParticipantsUpdated(friends));
    });
  }
}
