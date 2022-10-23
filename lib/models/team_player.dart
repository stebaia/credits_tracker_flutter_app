import 'package:credits_tracker_flutter_app/models/nba_person.dart';
import 'package:credits_tracker_flutter_app/models/player.dart';
import 'package:credits_tracker_flutter_app/models/team.dart';
import 'package:equatable/equatable.dart';

class TeamPlayer extends Equatable {
  final NbaPerson player;
  final Team team;
  TeamPlayer({required this.player, required this.team});

  @override
  List<Object?> get props => [player, team];
}
