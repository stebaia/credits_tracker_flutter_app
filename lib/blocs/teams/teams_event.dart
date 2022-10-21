part of 'teams_bloc.dart';

abstract class TeamsEvent extends Equatable {
  const TeamsEvent();
}

class FetchTeamsEvent extends TeamsEvent {
  const FetchTeamsEvent();

  @override
  List<Object?> get props => [];
}
