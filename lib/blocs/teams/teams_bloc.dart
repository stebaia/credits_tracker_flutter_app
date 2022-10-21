import 'dart:async';

import 'package:credits_tracker_flutter_app/errors/repository_error.dart';
import 'package:credits_tracker_flutter_app/models/player.dart';
import 'package:credits_tracker_flutter_app/models/team.dart';
import 'package:credits_tracker_flutter_app/repositories/players_repository.dart';
import 'package:credits_tracker_flutter_app/repositories/teams_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'teams_event.dart';
part 'teams_state.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  final TeamsRepository teamsRepository;

  TeamsBloc({required this.teamsRepository}) : super(FetchingTeamsState()) {
    on<FetchTeamsEvent>(_onFetch);
  }

  FutureOr<void> _onFetch(
      FetchTeamsEvent event, Emitter<TeamsState> emitter) async {
    emit(FetchingTeamsState());

    try {
      final teams = await teamsRepository.teams();
      emit(teams.isEmpty ? NoTeamsState() : FetchedTeamsState(teams));
    } on RepositoryError catch (error) {
      emit(ErrorTeamsState(error.errorMessage));
    } catch (error) {
      emit(const ErrorTeamsState());
    }
  }

  void fetchTeams() => add(FetchTeamsEvent());
}
