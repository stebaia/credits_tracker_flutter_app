import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? personId;
  final String? teamId;
  final String? jersey;
  final String? pos;

  const Player(
      {required this.firstName,
      required this.lastName,
      required this.personId,
      required this.teamId,
      required this.jersey,
      required this.pos});

  Player.fromJson(Map<String, dynamic> map) : this(
    firstName: map["firstName"],
    lastName: map["lastName"],
    personId: map["personId"],
    teamId: map["teamId"],
    jersey: map["jersey"] is int ? map["jersey"] : (map["jersey"] != "" ? int.parse(map["jersey"]) : 0),
    pos: map["pos"]
  );

  Map<String, dynamic> toMap() {
    return {
      "personId" : personId,
      "firstName" : firstName,
      "lastName" : lastName,
      "jersey" : jersey,
      "pos" : pos,
      "teamId" : teamId
    };
  }

  List<Object?> get props => [
        firstName,
        lastName,
        personId,
        teamId,
        jersey,
        pos
      ];
}
