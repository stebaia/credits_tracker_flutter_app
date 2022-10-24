part of 'fanta_team_bloc.dart';

abstract class FantaTeamEvent extends Equatable {
  const FantaTeamEvent();
}

class AddPlayerAndFetchFantaTeamEvent extends FantaTeamEvent {
  AddPlayerAndFetchFantaTeamEvent({required this.player});
  final NbaPerson player;
  @override
  List<Object?> get props => [];
}

class LoginTeamEcent extends FantaTeamEvent {
  LoginTeamEcent({required this.username});
  final String username;
  @override
  List<Object?> get props => [];
}

class RemovePlayerAndFetchFantaTeamEvent extends FantaTeamEvent {
  RemovePlayerAndFetchFantaTeamEvent({required this.player});
  final NbaPerson player;
  @override
  List<Object?> get props => [];
}

class FetchFantaTeamEvent extends FantaTeamEvent {
  const FetchFantaTeamEvent();

  @override
  List<Object?> get props => [];
}
