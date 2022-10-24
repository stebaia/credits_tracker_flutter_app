import '../models/nba_person.dart';

List<NbaPerson> applyFilters(
    List<NbaPerson> players,
    Map<String, bool> positions,
    Map<String, bool> teams) {
  return players
      .where((p) =>
  filterByPosition(p, positions) &&
      filterByTeam(p, teams))
      .toList();
}

bool filterByPosition(NbaPerson p, Map<String, bool> positions) {
  return p.pos!.contains(RegExp(positions.keys
      .where((k) => positions[k]!)
      .reduce((acc, s) => "$acc|$s")));
}

bool filterByTeam(NbaPerson p, Map<String, bool> teams) {
  return (!teams.values.reduce((acc, e) => acc || e))
      || teams[teams.keys.firstWhere((k) => k == p.teamId)]!;
}