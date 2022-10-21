part of 'teams_bloc.dart';

abstract class TeamsState extends Equatable {
  const TeamsState();
  @override
  List<Object?> get props => [];
}

class FetchingTeamsState extends TeamsState {}

class FetchedTeamsState extends TeamsState {
  final List<Team> teams;
  const FetchedTeamsState(this.teams);
  @override
  List<Object?> get props => [teams];
}

class NoTeamsState extends TeamsState {}

class ErrorTeamsState extends TeamsState {
  final String? errorMessage;

  const ErrorTeamsState([this.errorMessage]);
  @override
  List<Object?> get props => [errorMessage];
}
