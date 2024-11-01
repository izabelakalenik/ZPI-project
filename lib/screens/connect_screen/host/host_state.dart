part of 'host_bloc.dart';

abstract class HostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HostInitial extends HostState {}

class HostRoomCreated extends HostState {
  final String roomCode;

  HostRoomCreated(this.roomCode);

  @override
  List<Object?> get props => [roomCode];
}

class HostParticipantsUpdated extends HostState {
  final List<String> friends;

  HostParticipantsUpdated(this.friends);

  @override
  List<Object?> get props => [friends];
}
