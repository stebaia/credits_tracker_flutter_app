import 'dart:ffi';

import 'package:equatable/equatable.dart';

class PlayerResponse extends Equatable {
  final LeagueDTO league;

  const PlayerResponse({
    required this.league,
  });

  factory PlayerResponse.fromJson(Map<String, dynamic> data) => PlayerResponse(
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
  final List<PlayerDTO> players;
  const LeagueDTO({
    required this.players,
  });
  factory LeagueDTO.fromJson(Map<String, dynamic> data) => LeagueDTO(
      players: (data['standard'] as List)
          .map((item) => PlayerDTO.fromJson(item as Map<String, dynamic>))
          .toList(growable: false));

  @override
  List<Object?> get props => [
        players,
      ];
}

class PlayerDTO extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? temporaryDisplayName;
  final String? personId;
  final String? teamId;
  final String? jersey;
  final bool? isActive;
  final String? pos;
  final String? heightFeet;
  final String? heightInches;
  final String? heightMeters;
  final String? weightPounds;
  final String? weightKilograms;
  final String? dateOfBirthUTC;
  final TeamSitesOnlyDTO? teamSitesOnly;
  final List<TeamsDTO>? teams;
  final DraftDTO? draft;
  final String? nbaDebutYear;
  final String? yearsPro;
  final String? collegeName;
  final String? lastAffiliation;
  final String? country;

  const PlayerDTO(
      {required this.firstName,
      required this.lastName,
      required this.temporaryDisplayName,
      required this.personId,
      required this.teamId,
      required this.jersey,
      required this.isActive,
      required this.pos,
      required this.heightFeet,
      required this.heightInches,
      required this.heightMeters,
      required this.weightPounds,
      required this.weightKilograms,
      required this.dateOfBirthUTC,
      required this.teamSitesOnly,
      required this.teams,
      required this.draft,
      required this.nbaDebutYear,
      required this.yearsPro,
      required this.collegeName,
      required this.lastAffiliation,
      required this.country});

  factory PlayerDTO.fromJson(Map<String, dynamic> data) {
    print(data['lastName']);
    return PlayerDTO(
      firstName: data['firstName'],
      lastName: data['lastName'],
      temporaryDisplayName: data['temporaryDisplayName'],
      personId: data['personId'],
      teamId: data['teamId'],
      jersey: data['jersey'],
      isActive: data['isActive'],
      pos: data['pos'],
      teamSitesOnly: data['teamSitesOnly'] != null
          ? TeamSitesOnlyDTO.fromJson(data['teamSitesOnly'])
          : TeamSitesOnlyDTO(
              playerCode: "",
              posFull: "",
              displayAffiliation: "",
              freeAgentCode: ""),
      draft: DraftDTO.fromJson(data['draft']),
      teams: (data['teams'] as List).length > 0
          ? (data['teams'] as List)
              .map((item) => TeamsDTO.fromJson(item as Map<String, dynamic>))
              .toList(growable: false)
          : [TeamsDTO(teamId: "0", seasonStart: "", seasonEnd: "")],
      heightFeet: data['heightFeet'],
      heightInches: data['heightInches'],
      heightMeters: data['heightMeters'],
      weightPounds: data['weightPounds'],
      weightKilograms: data['weightKilograms'],
      dateOfBirthUTC: data['dateOfBirthUTC'],
      nbaDebutYear: data['nbaDebutYear'],
      yearsPro: data['yearsPro'],
      collegeName: data['collegeName'],
      lastAffiliation: data['lastAffiliation'],
      country: data['country'],
    );
  }
  @override
  List<Object?> get props => [
        firstName,
        lastName,
        temporaryDisplayName,
        personId,
        teamId,
        jersey,
        isActive,
        pos,
        heightFeet,
        heightInches,
        heightMeters,
        weightPounds,
        weightKilograms,
        dateOfBirthUTC,
        teamSitesOnly,
        teams,
        draft,
        nbaDebutYear,
        yearsPro,
        collegeName,
        lastAffiliation,
        country
      ];
}

class TeamsDTO extends Equatable {
  final String? teamId;
  final String? seasonStart;
  final String? seasonEnd;

  const TeamsDTO(
      {required this.teamId,
      required this.seasonStart,
      required this.seasonEnd});

  factory TeamsDTO.fromJson(Map<String, dynamic> data) => TeamsDTO(
      teamId: data['teamId'],
      seasonStart: data['seasonStart'],
      seasonEnd: data['seasonEnd']);

  @override
  List<Object?> get props => [teamId, seasonStart, seasonEnd];
}

class TeamSitesOnlyDTO extends Equatable {
  final String? playerCode;
  final String? posFull;
  final String? displayAffiliation;
  final String? freeAgentCode;

  const TeamSitesOnlyDTO(
      {required this.playerCode,
      required this.posFull,
      required this.displayAffiliation,
      required this.freeAgentCode});

  factory TeamSitesOnlyDTO.fromJson(Map<String, dynamic> data) =>
      TeamSitesOnlyDTO(
          playerCode: data['playerCode'],
          posFull: data['posFull'],
          displayAffiliation: data['displayAffiliation'],
          freeAgentCode: data['freeAgentCode']);

  @override
  List<Object?> get props =>
      [playerCode, posFull, displayAffiliation, freeAgentCode];
}

class DraftDTO extends Equatable {
  final String? teamId;
  final String? pickNum;
  final String? roundNum;
  final String? seasonYear;

  const DraftDTO(
      {required this.teamId,
      required this.pickNum,
      required this.roundNum,
      required this.seasonYear});

  factory DraftDTO.fromJson(Map<String, dynamic> data) => DraftDTO(
      teamId: data['teamId'],
      pickNum: data['pickNum'],
      roundNum: data['roundNum'],
      seasonYear: data['seasonYear']);

  @override
  List<Object?> get props => [teamId, pickNum, roundNum, seasonYear];
}
