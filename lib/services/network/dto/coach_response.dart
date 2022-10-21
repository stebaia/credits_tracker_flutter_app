import 'package:equatable/equatable.dart';

class CoachResponse extends Equatable {
  final LeagueDTO league;

  const CoachResponse({
    required this.league,
  });

  factory CoachResponse.fromJson(Map<String, dynamic> data) => CoachResponse(
        league: LeagueDTO.fromJson(data['league']),
        //paging: PagingDTO.fromJson(data['paging']),
        /*league: (data['league'] as List)
          .map((item) => PlayerDTO.fromJson(item as Map<String, dynamic>))
          .toList(growable: false));*/
      );

  @override
  List<Object?> get props => [
        league,
      ];
}

class LeagueDTO extends Equatable {
  final List<CoachDTO> coaches;
  const LeagueDTO({
    required this.coaches,
  });
  factory LeagueDTO.fromJson(Map<String, dynamic> data) => LeagueDTO(
      coaches: (data['standard'] as List)
          .map((item) => CoachDTO.fromJson(item as Map<String, dynamic>))
          .toList(growable: false));

  @override
  List<Object?> get props => [
        coaches,
      ];
}

class CoachDTO extends Equatable {
  final String? firstName;
  final String? lastName;
  final bool? isAssistant;
  final String? personId;
  final String? teamId;
  final String? sortSequence;
  final String? college;
  final TeamSitesOnlyDTO? teamSitesOnly;

  const CoachDTO(
      {required this.firstName,
      required this.lastName,
      required this.isAssistant,
      required this.personId,
      required this.teamId,
      required this.sortSequence,
      required this.college,
      required this.teamSitesOnly});
  factory CoachDTO.fromJson(Map<String, dynamic> data) => CoachDTO(
        firstName: data['firstName'],
        lastName: data['lastName'],
        isAssistant: data['isAssistant'],
        personId: data['personId'],
        teamId: data['teamId'],
        sortSequence: data['sortSequence'],
        college: data['college'],
        teamSitesOnly: TeamSitesOnlyDTO.fromJson(data['teamSitesOnly']),
      );

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        isAssistant,
        personId,
        teamId,
        sortSequence,
        college,
        teamSitesOnly
      ];
}

class TeamSitesOnlyDTO extends Equatable {
  final String? displayName;
  final String? coachCode;
  final String? coachRole;
  final String? teamCode;
  final String? teamTricode;

  const TeamSitesOnlyDTO(
      {required this.displayName,
      required this.coachCode,
      required this.coachRole,
      required this.teamCode,
      required this.teamTricode});

  factory TeamSitesOnlyDTO.fromJson(Map<String, dynamic> data) =>
      TeamSitesOnlyDTO(
          displayName: data['displayName'],
          coachCode: data['coachCode'],
          coachRole: data['coachRole'],
          teamCode: data['teamCode'],
          teamTricode: data['teamTricode']);

  @override
  List<Object?> get props =>
      [displayName, coachCode, coachRole, teamCode, teamTricode];
}
