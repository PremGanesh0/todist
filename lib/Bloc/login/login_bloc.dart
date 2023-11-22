import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todist/Bloc/login/api.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    String uri = 'https://dev.taskpareto.com/api/';
    on<LoginButtonPressed>(Apis().login);
  }
}
