import 'package:credits_tracker_flutter_app/blocs/fanta_team/fanta_team_bloc.dart';
import 'package:credits_tracker_flutter_app/models/fanta_team.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
          if (state is FetchedFantaTeamState) {
            return CustomScrollView(slivers: [
              SliverToBoxAdapter(
                  child: SizedBox(
                      height: 550,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemExtent: size.width * 0.8,
                          scrollDirection: Axis.horizontal,
                          itemCount: state.fantaTeams.length,
                          itemBuilder: ((context, index) => containerPlayer(
                                state.fantaTeams[index],
                                context,
                                themeChange.darkTheme
                                    ? Color(0xff171717)
                                    : Color.fromARGB(255, 236, 231, 231),
                                themeChange.darkTheme
                                    ? Color.fromARGB(255, 236, 231, 231)
                                    : Color(0xff171717),
                              )))))
            ]);
          } else {
            return Text('Error');
          }
        },
      ),
    );
  }

  Widget containerPlayer(FantaTeam fantaTeam, BuildContext context,
      Color background, Color textColor) {
    return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 0.6), //(x,y)
            blurRadius: 10.0,
          ),
        ], color: background, borderRadius: BorderRadius.circular(20)),
        width: 300,
        height: 200,
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                fantaTeam.coachId,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: textColor),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "${fantaTeam.credits} crediti",
                style: TextStyle(color: textColor),
              )
            ],
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: fantaTeam.players.length,
              itemBuilder: ((context, index) => Container(
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.all(6),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "${fantaTeam.players[index].firstName} ${fantaTeam.players[index].lastName}",
                  )))),
        ]));
  }
}
