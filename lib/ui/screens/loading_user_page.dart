import 'dart:math';

import 'package:credits_tracker_flutter_app/blocs/login/login_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'home_page.dart';

class LoadingUserPage extends StatefulWidget {
  const LoadingUserPage({Key? key, required this.username}) : super(key: key);
  final String username;
  @override
  State<LoadingUserPage> createState() => _LoadingUserPageState();
}

class _LoadingUserPageState extends State<LoadingUserPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        lazy: false,
        create: (context) =>
            LoginBloc(username: widget.username)..login(widget.username),
        child: Scaffold(
            body: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          if (state is FetchingLoginState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset('assets/basket.json'),
                Text('Che i gufi siano con te')
              ],
            );
          } else {
            return HomePage(username: widget.username);
          }
        })));
  }
}
