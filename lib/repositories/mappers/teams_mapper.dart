import 'package:credits_tracker_flutter_app/misc/mapper.dart';
import 'package:credits_tracker_flutter_app/models/team.dart';
import 'package:credits_tracker_flutter_app/services/network/dto/teams_response.dart';

class TeamsMapper extends DTOMapper<TeamsDTO, Team> {
  @override
  Team toModel(TeamsDTO dto) => Team(
      isNBAFranchise: dto.isNBAFranchise,
      city: dto.city,
      altCityName: dto.altCityName,
      fullName: dto.fullName,
      tricode: dto.tricode,
      teamId: dto.teamId);

  @override
  TeamsDTO toTrasnferObject(Team model) {
    throw UnimplementedError();
  }
}
