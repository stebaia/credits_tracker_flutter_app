import 'package:credits_tracker_flutter_app/blocs/fanta_team/fanta_team_bloc.dart';
import 'package:credits_tracker_flutter_app/blocs/teams/teams_bloc.dart';
import 'package:credits_tracker_flutter_app/models/fanta_team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../models/nba_person.dart';
import '../../models/team.dart';
import '../../provider/dark_theme_provider.dart';

class EnemyTeamPage extends StatelessWidget {
  const EnemyTeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    return Container(
      child: BlocBuilder<FantaTeamBloc, FantaTeamState>(
        builder: (context, state) {
          return BlocBuilder<TeamsBloc, TeamsState>(
            builder: (teamsContext, teamState) {
              if (state is FetchedFantaTeamState &&
                  teamState is FetchedTeamsState) {
                return CustomScrollView(slivers: [
                  SliverToBoxAdapter(
                      child: SizedBox(
                          height: 600,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemExtent: size.width * 0.8,
                              scrollDirection: Axis.horizontal,
                              itemCount: state.fantaTeams.length,
                              itemBuilder: ((context, index) => containerPlayer(
                                    state.fantaTeams[index],
                                    teamState.teams,
                                    context,
                                    themeChange.darkTheme
                                        ? const Color(0xff171717)
                                        : const Color.fromARGB(
                                            255, 236, 231, 231),
                                    themeChange.darkTheme
                                        ? const Color.fromARGB(
                                            255, 236, 231, 231)
                                        : const Color(0xff171717),
                                  )))))
                ]);
              } else {
                return const Text('Error');
              }
            },
          );
        },
      ),
    );
  }

  Widget containerPlayer(FantaTeam fantaTeam, List<Team> teams,
      BuildContext context, Color background, Color textColor) {
    fantaTeam.players.sort(sortNbaPlayers);
    return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 0.6), //(x,y)
            blurRadius: 10.0,
          ),
        ], color: background, borderRadius: BorderRadius.circular(20)),
        width: 300,
        height: 200,
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                width: 5,
              ),
              Text(
                fantaTeam.fullName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: textColor),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                "${fantaTeam.credits} crediti",
                style: TextStyle(color: textColor),
              ),
              const SizedBox(
                width: 5,
              )
            ],
          ),
          SizedBox(
            height: 6,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: fantaTeam.players.length,
              itemBuilder: ((context, index) => Container(
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(
                      left: 6.0, top: 4.0, right: 6.0, bottom: 4.0),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          flex: 4,
                          child: Text(
                            "${fantaTeam.players[index].firstName} ${fantaTeam.players[index].lastName}",
                          )),
                      Expanded(
                          flex: 1,
                          child: Center(
                              child: Text("${fantaTeam.players[index].pos}"))),
                      Expanded(
                          flex: 1,
                          child: Center(
                              child: Text(
                                  "${teams.firstWhere((t) => t.teamId == fantaTeam.players[index].teamId).tricode}"))),
                    ],
                  )))),
        ]));
  }

  int sortNbaPlayers(NbaPerson a, NbaPerson b) {
    return b.pos == "HC" ? 1 : a.lastName!.compareTo(b.lastName!);
  }
}
