import 'package:credits_tracker_flutter_app/blocs/coaches/coaches_bloc.dart';
import 'package:credits_tracker_flutter_app/blocs/fanta_team/fanta_team_bloc.dart';
import 'package:credits_tracker_flutter_app/blocs/navigation/navigation_cubit.dart';
import 'package:credits_tracker_flutter_app/blocs/teams/teams_bloc.dart';
import 'package:credits_tracker_flutter_app/provider/dark_theme_provider.dart';
import 'package:credits_tracker_flutter_app/repositories/coaches_repository.dart';
import 'package:credits_tracker_flutter_app/repositories/mappers/coach_mapper.dart';
import 'package:credits_tracker_flutter_app/repositories/mappers/player_mapper.dart';
import 'package:credits_tracker_flutter_app/repositories/mappers/teams_mapper.dart';
import 'package:credits_tracker_flutter_app/repositories/players_repository.dart';
import 'package:credits_tracker_flutter_app/repositories/teams_repository.dart';
import 'package:credits_tracker_flutter_app/services/network/coach_service.dart';
import 'package:credits_tracker_flutter_app/services/network/players_service.dart';
import 'package:credits_tracker_flutter_app/services/network/teams_service.dart';
import 'package:credits_tracker_flutter_app/ui/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'blocs/players/players_bloc.dart';
import 'ui/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  App({super.key});
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  static String baseUrl = "data.nba.net";
  DarkThemeProvider themeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeProvider.darkTheme =
        await themeProvider.darkThemePreferences.getTheme();
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider<DarkThemeProvider>(
                create: (_) => themeProvider),
            Provider<PlayerMapper>(
              create: (_) => PlayerMapper(),
            ),
            Provider<CoachMapper>(
              create: (_) => CoachMapper(),
            ),
            Provider<TeamsMapper>(create: (_) => TeamsMapper())
          ],
          child: MultiProvider(
              providers: [
                Provider<PlayerService>(
                    create: (_) => PlayerService(baseUrl: baseUrl)),
                Provider<TeamsService>(
                    create: (_) => TeamsService(baseUrl: baseUrl)),
                Provider<CoachService>(
                    create: (_) => CoachService(baseUrl: baseUrl))
              ],
              child: MultiRepositoryProvider(
                  providers: [
                    RepositoryProvider<PlayersRepository>(
                        create: (context) => PlayersRepository(
                            playerMapper: context.read<PlayerMapper>(),
                            playerService: context.read<PlayerService>())),
                    RepositoryProvider<CoachesRepository>(
                        create: (context) => CoachesRepository(
                            coachMapper: context.read<CoachMapper>(),
                            coachService: context.read<CoachService>())),
                    RepositoryProvider<TeamsRepository>(
                        create: (context) => TeamsRepository(
                            teamsMapper: context.read<TeamsMapper>(),
                            teamsService: context.read<TeamsService>())),
                  ],
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(create: ((context) => NavigationCubit())),
                      BlocProvider(
                        create: ((context) => PlayersBloc(
                            playersRepository:
                                context.read<PlayersRepository>())
                          ..fetchPlayers()),
                        lazy: false,
                      ),
                      BlocProvider(
                        create: ((context) => TeamsBloc(
                            teamsRepository: context.read<TeamsRepository>())
                          ..fetchTeams()),
                        lazy: false,
                      ),
                      BlocProvider(
                        create: ((context) => CoachesBloc(
                            coachesRepository:
                                context.read<CoachesRepository>())
                          ..fetchCoaches()),
                        lazy: false,
                      )
                    ],
                    child: MaterialApp(
                        debugShowCheckedModeBanner: false,
                        title: 'FantaCoach',
                        theme: ThemeData(
                          fontFamily: 'Poppins',
                          primarySwatch: Colors.orange,
                          scaffoldBackgroundColor: Colors.white,
                          useMaterial3: true,
                          appBarTheme: const AppBarTheme(
                              titleTextStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                              backgroundColor: Colors.orange,
                              elevation: 5),
                        ),
                        home: LoginScreen()),
                  ))));
}
