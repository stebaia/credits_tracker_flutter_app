import 'package:credits_tracker_flutter_app/misc/mapper.dart';
import 'package:credits_tracker_flutter_app/models/coach.dart';
import 'package:credits_tracker_flutter_app/services/network/dto/coach_response.dart';

class CoachMapper extends DTOMapper<CoachDTO, Coach> {
  @override
  Coach toModel(CoachDTO dto) => Coach(
      firstName: dto.firstName,
      lastName: dto.lastName,
      personId: dto.personId,
      teamId: dto.teamId,
      isAssistant: dto.isAssistant
  );

  @override
  CoachDTO toTrasnferObject(Coach model) {
    throw UnimplementedError();
  }
}
