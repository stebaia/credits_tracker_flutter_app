import 'dart:async';

import 'package:credits_tracker_flutter_app/blocs/players/players_bloc.dart';
import 'package:credits_tracker_flutter_app/errors/repository_error.dart';
import 'package:credits_tracker_flutter_app/models/coach.dart';
import 'package:credits_tracker_flutter_app/models/player.dart';
import 'package:credits_tracker_flutter_app/repositories/coaches_repository.dart';
import 'package:credits_tracker_flutter_app/repositories/players_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'coaches_event.dart';
part 'coaches_state.dart';

class CoachesBloc extends Bloc<CoachesEvent, CoachesState> {
  final CoachesRepository coachesRepository;

  CoachesBloc({required this.coachesRepository})
      : super(FetchingCoachesState()) {
    on<FetchCoachesEvent>(_onFetch);
  }

  FutureOr<void> _onFetch(
      FetchCoachesEvent event, Emitter<CoachesState> emitter) async {
    emit(FetchingCoachesState());

    try {
      final coaches = await coachesRepository.coaches();
      emit(coaches.isEmpty ? NoCoachesState() : FetchedCoachesState(coaches));
    } on RepositoryError catch (error) {
      emit(ErrorCoachState(error.errorMessage));
    } catch (error) {
      emit(const ErrorCoachState());
    }
  }

  void fetchCoaches() => add(FetchCoachesEvent());
}
