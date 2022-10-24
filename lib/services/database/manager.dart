import 'package:mongo_dart/mongo_dart.dart';
import 'package:http/http.dart' as http;

import '../../models/fanta_coach.dart';
import '../../models/fanta_team.dart';
import '../../models/nba_person.dart';
import '../../utils/monads.dart';
import 'db.dart';

const String nbaDataDomain = "data.nba.net";

const String fantaCoachCollection = "FantaCoaches";
const String fantaTeamsCollection = "FantaTeams";

const String championshipName = "name";
const String championshipNameValue = "dunkettola";

const String fantacoachesList = "fantacoaches";
const String fantateamsList = "fantateams";

/// Contains the principal api of the application.
/// It is the interface for http requests and database access.
class NetworkManager {
  static String user = "";

  static init(String username) {
    user = username;
  }

  static Future<Db> openDb() async {
    var db = await createDatabase(user);
    await db.open();
    return db;
  }

  /* READ OPERATIONS */

  /// Returns the list of fantacoaches of the championship.
  static Future<List<FantaCoach>> getFantaCoaches() async {
    var db = await openDb();
    var coaches = await db
        .collection(fantaCoachCollection)
        .findOne(where.eq(championshipName, championshipNameValue));
    return (coaches![fantacoachesList] as List)
        .map((e) => FantaCoach.fromJson(e))
        .toList();
  }

  /// Returns the fantacoach with the specified id
  static Future<FantaCoach> getFantaCoach(String coachId) async {
    List<FantaCoach> coaches = await getFantaCoaches();
    return coaches.firstWhere((fc) => fc.id == coachId);
  }

  /// Returns all the fanta teams
  static Future<List<FantaTeam>> getFantaTeams() async {
    var db = await openDb();
    var teams = await db.collection(fantaTeamsCollection).modernFindOne(
        selector: where.eq(championshipName, championshipNameValue));
    return (teams![fantateamsList] as List)
        .map((t) =>
            FantaTeam.fromJson(t).also((t) => t.players.sort(sortNbaPlayers)))
        .toList();
  }

  /// Returns the fanta team of the specified fantacoach
  static Future<FantaTeam> getFantaTeam(String coachId) async {
    var teams = await getFantaTeams();
    return teams.firstWhere((t) => t.coachId == coachId);
  }

  /* UPDATE OPERATIONS */

  /// Reduces the credits of the specified fanta coach
  static void spendCredits(String coachId, int amount) async {
    var db = await openDb();
    db.collection(fantaCoachCollection).modernUpdate(
        where.eq("$fantacoachesList.id", coachId),
        modify.inc("$fantacoachesList.\$.credits", -amount));
  }

  /// Adds a player or head coach to the team of the specified fanta coach
  static Future<Map<String, dynamic>> addToTeam(
      String coachId, NbaPerson p) async {
    var db = await openDb();
    return db.collection(fantaTeamsCollection).modernUpdate(
        where.eq("$fantateamsList.coachId", coachId),
        modify.push("$fantateamsList.\$.players", p.toMap()));
  }

  /// Removes a player or head coach from the team of the specified fanta coach
  static Future<Map<String, dynamic>> removeFromTeam(
      String coachId, NbaPerson p) async {
    var db = await openDb();
    return db.collection(fantaTeamsCollection).modernUpdate(
        where.eq("$fantateamsList.coachId", coachId),
        modify.pull("$fantateamsList.\$.players", {"personId": p.personId}));
  }
}

int sortNbaPlayers(NbaPerson a, NbaPerson b) {
  return a.lastName!.compareTo(b.lastName!);
}
