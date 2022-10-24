part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginUserEvent extends LoginEvent {
  LoginUserEvent({required this.username});
  final String username;
  @override
  List<Object?> get props => [];
}
