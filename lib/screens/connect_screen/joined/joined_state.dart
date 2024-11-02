part of 'joined_bloc.dart';

abstract class JoinedState extends Equatable {
  @override
  List<Object?> get props => [];
}

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