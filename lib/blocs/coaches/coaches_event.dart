part of 'coaches_bloc.dart';

abstract class CoachesEvent extends Equatable {
  const CoachesEvent();
}

class FetchCoachesEvent extends CoachesEvent {
  const FetchCoachesEvent();

  @override
  List<Object?> get props => [];
}
