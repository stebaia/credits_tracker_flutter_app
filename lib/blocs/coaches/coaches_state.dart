part of 'coaches_bloc.dart';

abstract class CoachesState extends Equatable {
  const CoachesState();
  @override
  List<Object?> get props => [];
}

class FetchingCoachesState extends CoachesState {}

class FetchedPCoachesState extends CoachesState {
  final List<Coach> coaches;
  const FetchedPCoachesState(this.coaches);
  @override
  List<Object?> get props => [coaches];
}

class NoCoachesState extends CoachesState {}

class ErrorPlayersState extends CoachesState {
  final String? errorMessage;

  const ErrorPlayersState([this.errorMessage]);
  @override
  List<Object?> get props => [errorMessage];
}
