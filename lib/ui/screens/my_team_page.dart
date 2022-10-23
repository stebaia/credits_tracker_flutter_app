import 'package:credits_tracker_flutter_app/blocs/teams/teams_bloc.dart';
import 'package:credits_tracker_flutter_app/models/fanta_team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/fanta_team/fanta_team_bloc.dart';
import '../../models/nba_person.dart';
import '../../models/team.dart';
import '../../models/team_player.dart';

class MyTeamPage extends StatelessWidget {
  const MyTeamPage({Key? key, required this.coachId, this.removed = const []}) : super(key: key);

  final String coachId;
  final List<NbaPerson> removed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<FantaTeamBloc, FantaTeamState>(
        builder: (context, fantateamState) {
          return BlocBuilder<TeamsBloc, TeamsState>(
            builder: (context, teamState) {
              if (fantateamState is FetchedFantaTeamState && teamState is FetchedTeamsState) {
                FantaTeam myTeam = fantateamState.fantaTeams.firstWhere((t) =>
                t.coachId == coachId);
                myTeam.players.sort(sortNbaPlayers);
                return ListView.builder(
                    itemCount: myTeam.players.length,
                    itemBuilder: ((context, index) =>
                        playerWidget(
                            myTeam.players[index],
                            teamState.teams
                        )));
              } else {
                return const Text('Error');
              }
            }
          );
        },
      ),
    );
  }

  Widget playerWidget(NbaPerson player, List<Team> teams) {
    TeamPlayer teamPlayer;
    if (player.teamId != "") {
      teamPlayer = TeamPlayer(
          player: player,
          team:
          teams.where((element) => element.teamId == player.teamId).first);
      return Card(
          elevation: 6,
          child: Column(children: [
            Container(
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(176, 226, 117, 67),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                          teamPlayer.player.pos!,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
                  title: Text(
                    "${teamPlayer.player.firstName!} ${teamPlayer.player.lastName!}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("${teamPlayer.team.fullName}"),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: Text(
                    removed.any((p) => p.personId == player.personId) ? 'Rimosso' : 'Rimuovi',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (removed.any((p) => p.personId == player.personId)) {
                      removed.removeWhere((p) => p.personId == player.personId);
                    } else {
                      removed.add(player);
                    }
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ]));
    } else {
      return Container();
    }
  }

  int sortNbaPlayers(NbaPerson a, NbaPerson b) {
    return a.pos == "HC" ? -1 : a.lastName!.compareTo(b.lastName!);
  }
}
