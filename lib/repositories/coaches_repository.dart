import 'package:credits_tracker_flutter_app/errors/networ_error.dart';
import 'package:credits_tracker_flutter_app/errors/repository_error.dart';
import 'package:credits_tracker_flutter_app/models/coach.dart';
import 'package:credits_tracker_flutter_app/repositories/mappers/coach_mapper.dart';
import 'package:credits_tracker_flutter_app/services/network/coach_service.dart';

class CoachesRepository {
  final CoachService coachService;
  final CoachMapper coachMapper;

  CoachesRepository({required this.coachService, required this.coachMapper});

  Future<List<Coach>> players() async {
    try {
      final response = await coachService.coaches();
      return response.map(coachMapper.toModel).toList(growable: false);
    } on NetworkError catch (e) {
      throw RepositoryError(e.reasonPhrase);
    } catch (e) {
      throw RepositoryError();
    }
  }
}
