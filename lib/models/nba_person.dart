import 'package:equatable/equatable.dart';

class NbaPerson extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? personId;
  final String? teamId;
  final String? pos;
  final String? owner;

  const NbaPerson(
      {required this.firstName,
        required this.lastName,
        required this.personId,
        required this.teamId,
        required this.pos,
        this.owner});

  NbaPerson.fromJson(Map<String, dynamic> map) : this(
      firstName: map["firstName"],
      lastName: map["lastName"],
      personId: map["personId"],
      teamId: map["teamId"],
      pos: map["pos"]
  );

  Map<String, dynamic> toMap() {
    return {
      "personId" : personId,
      "firstName" : firstName,
      "lastName" : lastName,
      "pos" : pos,
      "teamId" : teamId
    };
  }

  NbaPerson ownedBy(String newOwner) {
    return NbaPerson(
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
