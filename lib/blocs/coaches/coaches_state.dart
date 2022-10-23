part of 'coaches_bloc.dart';

abstract class CoachesState extends Equatable {
  const CoachesState();
  @override
  List<Object?> get props => [];
}

class FetchingCoachesState extends CoachesState {}

class FetchedCoachesState extends CoachesState {
  final List<Coach> coaches;
  const FetchedCoachesState(this.coaches);
  @override
  List<Object?> get props => [coaches];
}

class NoCoachesState extends CoachesState {}

class ErrorCoachState extends CoachesState {
  final String? errorMessage;

  const ErrorCoachState([this.errorMessage]);
  @override
  List<Object?> get props => [errorMessage];
}
