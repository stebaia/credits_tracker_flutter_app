import 'package:credits_tracker_flutter_app/services/network/dto/player_response.dart';
import 'package:equatable/equatable.dart';

class TeamsResponse extends Equatable {
  final LeagueDTO league;

  const TeamsResponse({
    required this.league,
  });

  factory TeamsResponse.fromJson(Map<String, dynamic> data) => TeamsResponse(
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
  final List<TeamsDTO> teams;
  const LeagueDTO({
    required this.teams,
  });
  factory LeagueDTO.fromJson(Map<String, dynamic> data) => LeagueDTO(
      teams: (data['standard'] as List)
          .map((item) => TeamsDTO.fromJson(item as Map<String, dynamic>))
          .toList(growable: false));

  @override
  List<Object?> get props => [
        teams,
      ];
}

class TeamsDTO extends Equatable {
  final bool? isNBAFranchise;
  final bool? isAllStar;
  final String? city;
  final String? altCityName;
  final String? fullName;
  final String? tricode;
  final String? teamId;
  final String? nickname;
  final String? urlName;
  final String? teamShortName;
  final String? confName;
  final String? divName;

  const TeamsDTO(
      {required this.isNBAFranchise,
      required this.isAllStar,
      required this.city,
      required this.altCityName,
      required this.fullName,
      required this.tricode,
      required this.teamId,
      required this.nickname,
      required this.urlName,
      required this.teamShortName,
      required this.confName,
      required this.divName});
  factory TeamsDTO.fromJson(Map<String, dynamic> data) => TeamsDTO(
      isNBAFranchise: data['isNBAFranchise'],
      isAllStar: data['isAllStar'],
      city: data['city'],
      altCityName: data['altCityName'],
      fullName: data['fullName'],
      tricode: data['tricode'],
      teamId: data['teamId'],
      nickname: data['nickname'],
      urlName: data['urlName'],
      teamShortName: data['teamShortName'],
      confName: data['confName'],
      divName: data['divName']);

  @override
  List<Object?> get props => [
        isNBAFranchise,
        isAllStar,
        city,
        altCityName,
        fullName,
        tricode,
        teamId,
        nickname,
        urlName,
        teamShortName,
        confName,
        divName
      ];
}
