part of 'players_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();
}

class FetchPlayerEvent extends PlayerEvent {
  const FetchPlayerEvent();

  @override
  List<Object?> get props => [];
}
