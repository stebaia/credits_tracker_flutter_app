import 'package:equatable/equatable.dart';

import 'nba_person.dart';

class FantaTeam extends Equatable {
  final String name;
  final String coachId;
  final String firstName;
  final String lastName;
  final String fullName;
  final int credits;
  final List<NbaPerson> players;

  const FantaTeam(
      {required this.name,
      required this.coachId,
      required this.firstName,
      required this.lastName,
      required this.fullName,
      required this.credits,
      required this.players});

  FantaTeam.fromJson(Map<String, dynamic> json)
      : this(
            name: json["name"],
            coachId: json["coachId"],
            firstName: json["firstName"],
            lastName: json["lastName"],
            fullName: "${json["firstName"]} ${json["lastName"]}",
            credits: json["credits"],
            players: [
              for (Map<String, dynamic> p in (json["players"] as List))
                NbaPerson.fromJson(p)
            ]);

  @override
  List<Object?> get props => [name, coachId, players];
}
