import 'dart:async';

import 'package:credits_tracker_flutter_app/errors/repository_error.dart';
import 'package:credits_tracker_flutter_app/models/player.dart';
import 'package:credits_tracker_flutter_app/repositories/players_repository.dart';
import 'package:credits_tracker_flutter_app/services/database/manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/fanta_team.dart';

part 'fanta_team_event.dart';
part 'fanta_team_state.dart';

class FantaTeamBloc extends Bloc<FantaTeamEvent, FantaTeamState> {

  final String username;

  FantaTeamBloc({required this.username})
      : super(FetchingFantaTeamState()) {
    on<FetchFantaTeamEvent>(_onFetch);
  }

  FutureOr<void> _onFetch(
      FetchFantaTeamEvent event, Emitter<FantaTeamState> emitter) async {
    emit(FetchingFantaTeamState());
    try {
      NetworkManager.init(username);
      NetworkManager.getFantaTeams().then((value) => emit(FetchedFantaTeamState(value)));
    } catch (error) {
      emit(const ErrorFantaTeamState());
    }

  }

  void fetchFantaTeams() => add(FetchFantaTeamEvent());
}
