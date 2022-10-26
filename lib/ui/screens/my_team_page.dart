import 'package:credits_tracker_flutter_app/blocs/teams/teams_bloc.dart';
import 'package:credits_tracker_flutter_app/models/fanta_team.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/fanta_team/fanta_team_bloc.dart';
import '../../models/nba_person.dart';
import '../../models/team.dart';
import '../../models/team_player.dart';
import '../../provider/dark_theme_provider.dart';

class MyTeamPage extends StatefulWidget {
  const MyTeamPage({Key? key, required this.coachId, this.removed = const []})
      : super(key: key);

  final String coachId;
  final List<NbaPerson> removed;
  @override
  State<MyTeamPage> createState() => _MyTeamState();
}

class _MyTeamState extends State<MyTeamPage> {
  var spendCredits = 0;
  var txt = TextEditingController();

  @override
  void initState() {
    context.read<FantaTeamBloc>().fetchFantaTeams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    //txt.text = spendCredits.toString();
    return Container(
      child: BlocBuilder<FantaTeamBloc, FantaTeamState>(
        builder: (context, fantateamState) {
          return BlocBuilder<TeamsBloc, TeamsState>(
              builder: (context, teamState) {
            if (fantateamState is FetchedFantaTeamState &&
                teamState is FetchedTeamsState) {
              FantaTeam myTeam = fantateamState.fantaTeams
                  .firstWhere((t) => t.coachId == widget.coachId);
              myTeam.players.sort(sortNbaPlayers);
              return Column(children: [
                Container(
                    color: themeChange.darkTheme
                        ? Color(0xff140b00)
                        : Color(0xffeed1a7),
                    height: 50,
                    width: 400,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Center(
                                  child: Text(
                            "Crediti: ${fantateamState.fantaTeams.firstWhere((ft) => ft.coachId == widget.coachId).credits}",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: themeChange.darkTheme
                                    ? CupertinoColors.white
                                    : CupertinoColors.black),
                          ))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              121, 211, 163, 91),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: IconButton(
                                        icon: const Icon(Icons.remove),
                                        padding: const EdgeInsets.all(3),
                                        onPressed: () {
                                          spendCredits = spendCredits - 1;
                                          txt.text = spendCredits.toString();
                                        },
                                      ))),
                              SizedBox(
                                width: 6,
                              ),
                              GestureDetector(
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              121, 211, 163, 91),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: IconButton(
                                        icon: const Icon(Icons.add),
                                        padding: const EdgeInsets.all(3),
                                        onPressed: () {
                                          spendCredits = spendCredits + 1;
                                          txt.text = spendCredits.toString();
                                        },
                                      ))),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  width: 80,
                                  height: 46,
                                  child: Center(
                                    child: CupertinoTextField(
                                      style: TextStyle(color: themeChange.darkTheme
                                ? Colors.white
                                : Colors.black),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: themeChange.darkTheme
                                              ? Colors.black
                                              : Colors.white),
                                      placeholder: "Spendi",
                                      enabled: true,
                                      controller: txt,
                                    ),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              121, 211, 163, 91),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: IconButton(
                                        icon: const Icon(Icons.money_off),
                                        padding: const EdgeInsets.all(3),
                                        onPressed: () {
                                          spendCredits = int.parse(txt.text);
                                          context
                                              .read<FantaTeamBloc>()
                                              .spendCreditsAndFetch(
                                                  spendCredits);
                                        },
                                      ))),
                            ],
                          ),
                        ],
                      ),
                    )),
                Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: myTeam.players.length + 1,
                        itemBuilder: ((context, index) {
                          if (index == myTeam.players.length) {
                            return const SizedBox(
                              height: 100,
                            );
                          } else {
                            return playerWidget(
                                myTeam.players[index],
                                teamState.teams,
                                context,
                                themeChange.darkTheme
                                    ? Color.fromARGB(228, 24, 29, 58)
                                    : CupertinoColors.white,
                                themeChange.darkTheme
                                    ? CupertinoColors.white
                                    : Colors.black);
                          }
                        }))),
              ]);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          });
        },
      ),
    );
  }

  Widget playerWidget(NbaPerson player, List<Team> teams, BuildContext context,
      Color color, Color titleColor) {
    TeamPlayer teamPlayer;
    if (player.teamId != "") {
      teamPlayer = TeamPlayer(
          player: player,
          team:
              teams.where((element) => element.teamId == player.teamId).first);
      return Card(
          color: color,
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
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: titleColor),
              ),
              subtitle: Text(
                "${teamPlayer.team.fullName}",
                style: TextStyle(color: titleColor),
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: Text(
                    widget.removed.any((p) => p.personId == player.personId)
                        ? 'Rimosso'
                        : 'Rimuovi',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    context.read<FantaTeamBloc>().removePlayerAndFetch(player);
                    /*if (removed.any((p) => p.personId == player.personId)) {
                      removed.removeWhere((p) => p.personId == player.personId);
                    } else {
                      removed.add(player);
                    }*/
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
    return b.pos == "HC" ? 1 : a.lastName!.compareTo(b.lastName!);
  }
}
