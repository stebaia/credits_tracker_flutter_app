import 'nba_person.dart';

class Player extends NbaPerson {

  const Player(
      {required super.firstName,
      required super.lastName,
      required super.personId,
      required super.teamId,
      required super.pos,
      super.owner});

  Player.fromJson(Map<String, dynamic> map) : this(
    firstName: map["firstName"],
    lastName: map["lastName"],
    personId: map["personId"],
    teamId: map["teamId"],
    pos: map["pos"]
  );

  @override
  NbaPerson ownedBy(String newOwner) {
    return Player(
        firstName: firstName,
        lastName: lastName,
        personId: personId,
        teamId: teamId,
        pos: pos,
        owner: newOwner
    );
  }

  List<Object?> get props => [
        firstName,
        lastName,
        personId,
        teamId,
        pos
      ];
}
