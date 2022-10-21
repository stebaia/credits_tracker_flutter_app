import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? temporaryDisplayName;
  final String? personId;
  final String? teamId;
  final String? jersey;
  final bool? isActive;
  final String? pos;

  const Player(
      {required this.firstName,
      required this.lastName,
      required this.temporaryDisplayName,
      required this.personId,
      required this.teamId,
      required this.jersey,
      required this.isActive,
      required this.pos});

  List<Object?> get props => [
        firstName,
        lastName,
        temporaryDisplayName,
        personId,
        teamId,
        jersey,
        isActive,
        pos
      ];
}
