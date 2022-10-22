part of 'fanta_team_bloc.dart';

abstract class FantaTeamState extends Equatable {
  const FantaTeamState();
  @override
  List<Object?> get props => [];
}

class FetchingFantaTeamState extends FantaTeamState {

}

class FetchedFantaTeamState extends FantaTeamState {
  final List<FantaTeam> fantaTeams;

  const FetchedFantaTeamState(this.fantaTeams);

  @override
  List<Object?> get props => [fantaTeams];
}

class ErrorFantaTeamState extends FantaTeamState {
  final String? errorMessage;

  const ErrorFantaTeamState([this.errorMessage]);
  @override
  List<Object?> get props => [errorMessage];
}

