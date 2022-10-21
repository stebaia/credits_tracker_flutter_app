import 'package:credits_tracker_flutter_app/models/player.dart';
import 'package:credits_tracker_flutter_app/models/team.dart';
import 'package:equatable/equatable.dart';

class TeamPlayer extends Equatable {
  final Player player;
  final Team team;
  TeamPlayer({required this.player, required this.team});

  @override
  List<Object?> get props => [player, team];
}
