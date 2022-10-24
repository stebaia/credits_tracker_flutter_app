part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

class FetchingLoginState extends LoginState {}

class FetchedLoginState extends LoginState {
  final bool ok;

  const FetchedLoginState(this.ok);

  @override
  List<Object?> get props => [ok];
}

class ErrorLoginState extends LoginState {
  final String? errorMessage;

  const ErrorLoginState([this.errorMessage]);
  @override
  List<Object?> get props => [errorMessage];
}
