import 'package:credits_tracker_flutter_app/errors/networ_error.dart';
import 'package:credits_tracker_flutter_app/errors/repository_error.dart';
import 'package:credits_tracker_flutter_app/models/player.dart';
import 'package:credits_tracker_flutter_app/repositories/mappers/player_mapper.dart';
import 'package:credits_tracker_flutter_app/services/network/players_service.dart';

class PlayersRepository {
  final PlayerService playerService;
  final PlayerMapper playerMapper;

  PlayersRepository({required this.playerMapper, required this.playerService});

  Future<List<Player>> players() async {
    try {
      final response = await playerService.players();
      return response.map(playerMapper.toModel).toList(growable: false);
    } on NetworkError catch (e) {
      throw RepositoryError(e.reasonPhrase);
    } catch (e) {
      throw RepositoryError();
    }
  }
}
