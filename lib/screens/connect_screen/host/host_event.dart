part of 'host_bloc.dart';

abstract class HostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateRoom extends HostEvent {}

class AddParticipant extends HostEvent {
  final String participantId;
  final String participantName;

  AddParticipant(this.participantId, this.participantName);

  @override
  List<Object?> get props => [participantId, participantName];
}