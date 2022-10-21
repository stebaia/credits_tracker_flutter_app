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

  @override
  List<Object?> get props => [firstName, lastName, personId, teamId];
}
