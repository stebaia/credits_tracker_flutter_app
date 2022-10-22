import 'package:equatable/equatable.dart';

class Coach extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? personId;
  final String? teamId;

  const Coach(
      {required this.firstName,
      required this.lastName,
      required this.personId,
      required this.teamId});

  Coach.fromJson(Map<String, dynamic> map) : this(
      firstName: map["firstName"],
      lastName: map["lastName"],
      personId: map["personId"],
      teamId: map["teamId"]
  );

  Map<String, dynamic> toMap() {
    return {
      "personId" : personId,
      "firstName" : firstName,
      "lastName" : lastName,
      "teamId" : teamId
    };
  }

  @override
  List<Object?> get props => [firstName, lastName, personId, teamId];
}
