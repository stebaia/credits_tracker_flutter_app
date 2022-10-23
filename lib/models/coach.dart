import 'package:credits_tracker_flutter_app/models/nba_person.dart';

class Coach extends NbaPerson {
  final bool? isAssistant;

  const Coach(
      {required super.firstName,
      required super.lastName,
      required super.personId,
      required super.teamId,
      required this.isAssistant,
      super.owner}) : super(pos: "HC");

  @override
  NbaPerson ownedBy(String newOwner) {
    return Coach(
      firstName: firstName,
      lastName: lastName,
      personId: personId,
      teamId: teamId,
      isAssistant: isAssistant,
      owner: newOwner
    );
  }

  @override
  List<Object?> get props => [firstName, lastName, personId, teamId];
}
