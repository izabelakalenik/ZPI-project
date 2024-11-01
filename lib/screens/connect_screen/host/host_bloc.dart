
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
        'participants': [user.username]
      });
        } else {
      await roomRef.set({
        'host': 'Anonymous Host',
        'participants': ['Anonymous Host']
      });
    }

    _participantsRef = roomRef.child('participants');
    _listenToParticipants(emit);
    emit(HostRoomCreated(roomCode));
  }

  Future<void> _onAddParticipant(AddParticipant event, Emitter<HostState> emit) async {

    final snapshot = await _participantsRef.once();
    List<dynamic> participants = snapshot.snapshot.value as List<dynamic>? ?? [];

    if (!participants.contains(event.participantName)) {
      participants.add(event.participantName);
      await _participantsRef.set(participants);
    }
  }

  void _listenToParticipants(Emitter<HostState> emit) {
    _participantsRef.onValue.listen((event) {
      final participantsSnapshot = event.snapshot.value as List<dynamic>? ?? [];
      final friends = participantsSnapshot.cast<String>();
      emit(HostParticipantsUpdated(friends));
    });
  }
}
