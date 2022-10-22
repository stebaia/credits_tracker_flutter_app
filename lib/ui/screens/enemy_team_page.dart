import 'package:credits_tracker_flutter_app/blocs/fanta_team/fanta_team_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnemyTeamPage extends StatelessWidget {
  const EnemyTeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: BlocBuilder<FantaTeamBloc, FantaTeamState>(
        builder: (context, state) {
          if (state is FetchedFantaTeamState) {
            return ListView.builder(
                itemCount: state.fantaTeams.length,
                itemBuilder: ((context, index) =>
                    Text(state.fantaTeams[index].name)));
          } else {
            return Text('Error');
          }
        },
      ),
    );
  }
}
