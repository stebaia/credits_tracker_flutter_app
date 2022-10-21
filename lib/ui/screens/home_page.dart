import 'package:credits_tracker_flutter_app/blocs/players/players_bloc.dart';
import 'package:credits_tracker_flutter_app/blocs/teams/teams_bloc.dart';
import 'package:credits_tracker_flutter_app/models/team_player.dart';
import 'package:credits_tracker_flutter_app/repositories/players_repository.dart';
import 'package:credits_tracker_flutter_app/ui/screens/player_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/navigation/constants/nav_bar_items.dart';
import '../../blocs/navigation/navigation_cubit.dart';
import '../../models/player.dart';
import '../../models/team.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> label = ['Home', 'Avversari', 'My Team', 'Impostazioni'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        return Text(label[state.index]);
      }),
    ), bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.orange,
            selectedItemColor: Colors.white,
            currentIndex: state.index,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: label[0],
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.people,
                ),
                label: label[1],
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: label[2],
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: label[3],
              ),
            ],
            onTap: (index) {
              if (index == 0) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.home);
              } else if (index == 1) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.enemyTeams);
              } else if (index == 2) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.myTeam);
              } else if (index == 3) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.settings);
              }
            });
      },
    ), body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      if (state.navbarItem == NavbarItem.home) {
        return PlayerListPage();
      } else if (state.navbarItem == NavbarItem.enemyTeams) {
        return PlayerListPage();
      } else if (state.navbarItem == NavbarItem.myTeam) {
        return PlayerListPage();
      } else if (state.navbarItem == NavbarItem.settings) {
        return PlayerListPage();
      }

      return Container();
    }));
  }
}
