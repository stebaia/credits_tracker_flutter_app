import 'dart:async';

import 'package:credits_tracker_flutter_app/errors/repository_error.dart';
import 'package:credits_tracker_flutter_app/models/player.dart';
import 'package:credits_tracker_flutter_app/repositories/players_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'players_event.dart';
part 'players_state.dart';

class PlayersBloc extends Bloc<PlayerEvent, PlayersState> {
  final PlayersRepository playersRepository;

  PlayersBloc({required this.playersRepository})
      : super(FetchingPlayersState()) {
    on<FetchPlayerEvent>(_onFetch);
  }

  FutureOr<void> _onFetch(
      FetchPlayerEvent event, Emitter<PlayersState> emitter) async {
    emit(FetchingPlayersState());

    try {
      final players = await playersRepository.players();
      emit(players.isEmpty ? NoPlayersState() : FetchedPlayersState(players));
    } on RepositoryError catch (error) {
      emit(ErrorPlayersState(error.errorMessage));
    } catch (error) {
      emit(const ErrorPlayersState());
    }
  }

  void fetchPlayers() => add(FetchPlayerEvent());
}
