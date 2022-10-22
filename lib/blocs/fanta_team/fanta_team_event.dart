part of 'fanta_team_bloc.dart';

abstract class FantaTeamEvent extends Equatable {
  const FantaTeamEvent();
}

class FetchFantaTeamEvent extends FantaTeamEvent {
  const FetchFantaTeamEvent();

  @override
  List<Object?> get props => [];
}
