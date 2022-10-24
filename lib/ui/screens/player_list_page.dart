import 'package:credits_tracker_flutter_app/blocs/coaches/coaches_bloc.dart';
import 'package:credits_tracker_flutter_app/blocs/fanta_team/fanta_team_bloc.dart';
import 'package:credits_tracker_flutter_app/services/database/manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/players/players_bloc.dart';
import '../../blocs/teams/teams_bloc.dart';
import '../../models/coach.dart';
import '../../models/fanta_team.dart';
import '../../models/nba_person.dart';
import '../../models/player.dart';
import '../../models/team.dart';
import '../../models/team_player.dart';
import '../../provider/dark_theme_provider.dart';

class PlayerListPage extends StatefulWidget {
  const PlayerListPage({Key? key, this.filter}) : super(key: key);

  final String? filter;
  @override
  State<PlayerListPage> createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerListPage> {
  TextEditingController controller = TextEditingController(text: '');
  String filter = "";
  @override
  void initState() {
    filter = controller.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
            color: themeChange.darkTheme
                ? Color(0xff171717)
                : Color.fromARGB(255, 236, 231, 231),
            height: 50,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      width: 200,
                      height: 46,
                      child: Center(
                          child: CupertinoTextField(
                        onChanged: (value) => {
                          setState(() {
                            filter = value;
                          })
                        },
                      ))),
                  Row(
                    children: [
                      GestureDetector(
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(121, 211, 163, 91),
                              borderRadius: BorderRadius.circular(30)),
                          child: Icon(Icons.filter_alt),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
        Expanded(
          child: BlocBuilder<PlayersBloc, PlayersState>(
            builder: (context, playersState) {
              return BlocBuilder<CoachesBloc, CoachesState>(
                  builder: (context, coachesState) {
                return BlocBuilder<FantaTeamBloc, FantaTeamState>(
                    builder: (context, ftState) {
                  if (playersState is FetchedPlayersState &&
                      coachesState is FetchedCoachesState &&
                      ftState is FetchedFantaTeamState) {
                    return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: _listWidget(
                            themeChange.darkTheme
                                ? CupertinoColors.white
                                : CupertinoColors.black,
                            themeChange.darkTheme
                                ? Color.fromARGB(228, 24, 29, 58)
                                : CupertinoColors.white,
                            filter,
                            players: playersState.players,
                            coaches: coachesState.coaches,
                            fantateams: ftState.fantaTeams));
                  } else if (playersState is ErrorPlayersState ||
                      coachesState is ErrorCoachState) {
                    return const Center(
                      child: Text('Errore generico'),
                    );
                  } else if (playersState is NoPlayersState ||
                      coachesState is NoCoachesState) {
                    return const Center(
                      child: Text('Nessun giocatore trovato'),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
              });
            },
          ),
        )
      ],
    );
  }

  Widget _listWidget(Color titleColor, Color color, String? filterName,
          {List<Player> players = const [],
          List<Coach> coaches = const [],
          List<FantaTeam> fantateams = const []}) =>
      BlocBuilder<TeamsBloc, TeamsState>(builder: (context, state) {
        if (state is FetchedTeamsState) {
          List<NbaPerson> completePlayers = [];
          completePlayers.addAll(players);
          completePlayers.addAll(coaches.where((c) => !c.isAssistant!));
          completePlayers.sort(sortNbaPlayers);
          completePlayers = completePlayers.map((p) {
            bool owned = fantateams
                .any((t) => t.players.any((tp) => tp.personId == p.personId));
            return owned
                ? p.ownedBy(fantateams
                    .firstWhere(
                        (t) => t.players.any((tp) => tp.personId == p.personId))
                    .coachId)
                : p;
          }).toList();
          if (filterName == null) {
            return ListView(
              children: completePlayers
                  .map((it) => playerWidget(
                        it,
                        state.teams,
                        fantateams,
                        color,
                        titleColor,
                      ))
                  .toList(),
            );
          } else {
            List<NbaPerson> filteredPlayer = completePlayers
                .where((element) =>
                    element.firstName!
                        .toLowerCase()
                        .contains(filterName.toLowerCase()) ||
                    element.lastName!
                        .toLowerCase()
                        .contains(filterName.toLowerCase()))
                .toList(growable: false);
            return ListView(
              children: filteredPlayer
                  .map((it) => playerWidget(
                        it,
                        state.teams,
                        fantateams,
                        color,
                        titleColor,
                      ))
                  .toList(),
            );
          }
        } else if (state is ErrorTeamsState) {
          return const Center(
            child: Text('Errore generico'),
          );
        } else if (state is NoTeamsState) {
          return const Center(
            child: Text('Nessun giocatore trovato'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      });

  Widget playerWidget(
    NbaPerson player,
    List<Team> teams,
    List<FantaTeam> fantateams,
    Color color,
    Color titleColor,
  ) {
    TeamPlayer teamPlayer;
    bool free = player.owner == null;
    String owner = free
        ? ''
        : fantateams.firstWhere((ft) => ft.coachId == player.owner!).fullName;
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 16),
                    Text(
                      free ? 'Libero' : 'Occupato: $owner',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: free ? Colors.lightGreen : Colors.redAccent),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      onPressed: !free
                          ? null
                          : () {
                              context
                                  .read<FantaTeamBloc>()
                                  .addPlayerAndFetch(player);
                            },
                      child: const Text(
                        'Aggiungi',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ]));
    } else {
      return Container();
    }
  }

  int sortNbaPlayers(NbaPerson a, NbaPerson b) {
    return a.lastName!.compareTo(b.lastName!);
  }
}
