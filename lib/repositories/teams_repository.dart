import 'package:credits_tracker_flutter_app/errors/networ_error.dart';
import 'package:credits_tracker_flutter_app/errors/repository_error.dart';
import 'package:credits_tracker_flutter_app/models/coach.dart';
import 'package:credits_tracker_flutter_app/models/team.dart';
import 'package:credits_tracker_flutter_app/repositories/mappers/coach_mapper.dart';
import 'package:credits_tracker_flutter_app/repositories/mappers/teams_mapper.dart';
import 'package:credits_tracker_flutter_app/services/network/coach_service.dart';
import 'package:credits_tracker_flutter_app/services/network/teams_service.dart';

class TeamsRepository {
  final TeamsService teamsService;
  final TeamsMapper teamsMapper;

  TeamsRepository({required this.teamsService, required this.teamsMapper});

  Future<List<Team>> teams() async {
    try {
      final response = await teamsService.teams();
      return response.map(teamsMapper.toModel).toList(growable: false);
    } on NetworkError catch (e) {
      throw RepositoryError(e.reasonPhrase);
    } catch (e) {
      throw RepositoryError();
    }
  }
}
