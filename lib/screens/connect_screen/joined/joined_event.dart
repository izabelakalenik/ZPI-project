part of 'joined_bloc.dart';

abstract class JoinedEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class JoinRoom extends JoinedEvent {
  final String roomCode;

  JoinRoom(this.roomCode);

  @override
  List<Object?> get props => [roomCode];
}