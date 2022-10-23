import 'package:credits_tracker_flutter_app/misc/mapper.dart';
import 'package:credits_tracker_flutter_app/models/player.dart';
import 'package:credits_tracker_flutter_app/services/network/dto/player_response.dart';

class PlayerMapper extends DTOMapper<PlayerDTO, Player> {
  @override
  Player toModel(PlayerDTO dto) => Player(
      firstName: dto.firstName,
      lastName: dto.lastName,
      personId: dto.personId,
      teamId: dto.teamId,
      pos: dto.pos);

  @override
  PlayerDTO toTrasnferObject(Player model) {
    throw UnimplementedError();
  }
}
