import 'package:credits_tracker_flutter_app/blocs/players/players_bloc.dart';
import 'package:credits_tracker_flutter_app/blocs/teams/teams_bloc.dart';
import 'package:credits_tracker_flutter_app/models/team_player.dart';
import 'package:credits_tracker_flutter_app/repositories/players_repository.dart';
import 'package:credits_tracker_flutter_app/ui/screens/enemy_team_page.dart';
import 'package:credits_tracker_flutter_app/ui/screens/my_team_page.dart';
import 'package:credits_tracker_flutter_app/ui/screens/player_list_page.dart';
import 'package:credits_tracker_flutter_app/ui/screens/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/fanta_team/fanta_team_bloc.dart';
import '../../blocs/navigation/constants/nav_bar_items.dart';
import '../../blocs/navigation/navigation_cubit.dart';
import '../../models/player.dart';
import '../../models/team.dart';
import '../../provider/dark_theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> label = ['Home', 'Avversari', 'My Team', 'Impostazioni'];

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return BlocProvider(
      lazy: false,
      create: (context) =>
          FantaTeamBloc(username: widget.username)..fetchFantaTeams(),
      child: Scaffold(
          backgroundColor: themeChange.darkTheme
              ? Color(0xff171717)
              : Color.fromARGB(255, 236, 231, 231),
          appBar: AppBar(
            title: BlocBuilder<NavigationCubit, NavigationState>(
                builder: (context, state) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label[state.index],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: themeChange.darkTheme
                              ? CupertinoColors.white
                              : CupertinoColors.black,
                          fontFamily: 'Poppins'),
                    ),
                    Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                            child: Text(
                          widget.username,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        )))
                  ]);
            }),
            backgroundColor:
                themeChange.darkTheme ? Colors.black : Color(0xffedd8bb),
          ),
          body: BlocBuilder<NavigationCubit, NavigationState>(
              builder: (context, state) {
            if (state.navbarItem == NavbarItem.home) {
              return generateBodyWithNavigationBar(
                  PlayerListPage(),
                  themeChange.darkTheme ? Colors.black : Color(0xffedd8bb),
                  themeChange.darkTheme
                      ? CupertinoColors.white
                      : CupertinoColors.black);
            } else if (state.navbarItem == NavbarItem.enemyTeams) {
              return generateBodyWithNavigationBar(
                  EnemyTeamPage(),
                  themeChange.darkTheme ? Colors.black : Color(0xffedd8bb),
                  themeChange.darkTheme
                      ? CupertinoColors.white
                      : CupertinoColors.black);
            } else if (state.navbarItem == NavbarItem.myTeam) {
              return generateBodyWithNavigationBar(
                  MyTeamPage(coachId: widget.username),
                  themeChange.darkTheme ? Colors.black : Color(0xffedd8bb),
                  themeChange.darkTheme
                      ? CupertinoColors.white
                      : CupertinoColors.black);
            } else if (state.navbarItem == NavbarItem.settings) {
              return generateBodyWithNavigationBar(
                  SettingsPage(),
                  themeChange.darkTheme ? Colors.black : Color(0xffedd8bb),
                  themeChange.darkTheme
                      ? CupertinoColors.white
                      : CupertinoColors.black);
            }

            return Container();
          })),
    );
  }

  Widget generateBodyWithNavigationBar(
      Widget child, Color colorNavbar, Color colorIcon) {
    return Stack(
      children: [
        child,
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: BlocBuilder<NavigationCubit, NavigationState>(
            builder: (context, state) {
              return Container(
                  decoration: BoxDecoration(
                      color: colorNavbar,
                      borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.all(10),
                  child: BottomNavigationBar(
                      backgroundColor: Colors.transparent,
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: colorIcon,
                      unselectedItemColor: Colors.grey,
                      currentIndex: state.index,
                      showSelectedLabels: false,
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
                      }));
            },
          ),
        )
      ],
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  final String username;

  MySearchDelegate({required this.username, r});
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              query = '';
            },
            icon: Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) => BlocProvider(
      lazy: false,
      create: (_) => FantaTeamBloc(username: username)..fetchFantaTeams(),
      child: PlayerListPage(
        filter: query,
      ));
  @override
  Widget buildSuggestions(BuildContext context) => BlocProvider(
      lazy: false,
      create: (_) => FantaTeamBloc(username: username)..fetchFantaTeams(),
      child: PlayerListPage(
        filter: query,
      ));
}
