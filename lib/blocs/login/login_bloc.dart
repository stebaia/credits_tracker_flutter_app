import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:credits_tracker_flutter_app/services/database/db.dart';
import 'package:credits_tracker_flutter_app/services/database/manager.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final String username;

  LoginBloc({required this.username}) : super(FetchingLoginState()) {
    on<LoginUserEvent>(_onLogin);
  }
  FutureOr<void> _onLogin(
      LoginUserEvent event, Emitter<LoginState> emitter) async {
    emit(FetchingLoginState());
    try {
      checkAccess(username).then((value) => emit(FetchedLoginState(value)));
    } catch (error) {
      emit(ErrorLoginState());
    }
  }

  void login(String username) => add(LoginUserEvent(username: username));
}
