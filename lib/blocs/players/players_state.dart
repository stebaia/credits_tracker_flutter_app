part of 'players_bloc.dart';

abstract class PlayersState extends Equatable {
  const PlayersState();
  @override
  List<Object?> get props => [];
}

class FetchingPlayersState extends PlayersState {}

class FetchedPlayersState extends PlayersState {
  final List<Player> players;
  const FetchedPlayersState(this.players);
  @override
  List<Object?> get props => [players];
}

class NoPlayersState extends PlayersState {}

class ErrorPlayersState extends PlayersState {
  final String? errorMessage;

  const ErrorPlayersState([this.errorMessage]);
  @override
  List<Object?> get props => [errorMessage];
}
