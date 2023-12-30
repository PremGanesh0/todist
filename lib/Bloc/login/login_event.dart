part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class CheckLoginEvent extends LoginEvent {
  CheckLoginEvent();
}

class LogoutButtonPressed extends LoginEvent {
  LogoutButtonPressed();
}
