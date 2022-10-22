import 'package:equatable/equatable.dart';

class NbaPerson extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? personId;
  final String? teamId;
  final String? pos;
  final bool? isFree;

  const NbaPerson(
      {required this.firstName,
        required this.lastName,
        required this.personId,
        required this.teamId,
        required this.pos,
        this.isFree});

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

  List<Object?> get props => [
    firstName,
    lastName,
    personId,
    teamId,
    pos
  ];
}
