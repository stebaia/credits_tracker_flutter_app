import 'package:equatable/equatable.dart';

import 'nba_person.dart';

class FantaTeam extends Equatable {
  final String name;
  final String coachId;
  final List<NbaPerson> players;

  const FantaTeam(
      {required this.name,
      required this.coachId,
      required this.players});

  FantaTeam.fromJson(Map<String, dynamic> json) : this(
      name: json["name"],
      coachId: json["coachId"],
      players: [for (Map<String, dynamic> p in (json["players"] as List)) NbaPerson.fromJson(p)]
  );

  @override
  List<Object?> get props =>
      [name, coachId, players];
}
