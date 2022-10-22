import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/players/players_bloc.dart';
import '../../blocs/teams/teams_bloc.dart';
import '../../models/player.dart';
import '../../models/team.dart';
import '../../models/team_player.dart';

class PlayerListPage extends StatelessWidget {
  const PlayerListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: size.height,
        minWidth: size.width,
      ),
      child: BlocBuilder<PlayersBloc, PlayersState>(
        builder: (context, state) {
          if (state is FetchedPlayersState) {
            return Padding(
                padding: EdgeInsets.all(4),
                child: _listWidget(context, players: state.players));
          } else if (state is ErrorPlayersState) {
            return const Center(
              child: Text('Errore generico'),
            );
          } else if (state is NoPlayersState) {
            return const Center(
              child: Text('Nessun giocatore trovato'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _listWidget(BuildContext context, {List<Player> players = const []}) =>
      BlocBuilder<TeamsBloc, TeamsState>(builder: (context, state) {
        if (state is FetchedTeamsState) {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => playerWidget(
              players[index],
              state.teams,
            ),
            itemCount: players.length,
          );
        } else if (state is ErrorTeamsState) {
          return const Center(
            child: Text('Errore generico'),
          );
        } else if (state is NoTeamsState) {
          return const Center(
            child: Text('Nessun giocatore trovato'),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      });

  Widget playerWidget(Player player, List<Team> teams) {
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
                padding: EdgeInsets.all(4),
                child: Center(
                    child: Text(
                  teamPlayer.player.pos!,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20)),
              ),
              title: Text(
                "${teamPlayer.player.firstName!} ${teamPlayer.player.lastName!}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${teamPlayer.team.fullName}"),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text(
                    'Aggiungi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ]));
    } else {
      return Container();
    }
  }
}
