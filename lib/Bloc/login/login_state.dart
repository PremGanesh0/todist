part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginSuccess extends LoginState {
  final User user;
  const LoginSuccess({required this.user});
  @override
  List<Object> get props => [user];
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginFailure extends LoginState {
  final String error;
  const LoginFailure({required this.error});
  @override
  List<Object> get props => [error];
}

class LoggedInState extends LoginState {
  const LoggedInState();
}

class LoggedOutState extends LoginState {
  const LoggedOutState();
}
