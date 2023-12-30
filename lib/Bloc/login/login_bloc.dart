import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/api/login_api.dart';
import 'package:todist/model/user_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    on<LoginButtonPressed>(loginApi);
    on<CheckLoginEvent>(checkLogin);
    on<LogoutButtonPressed>(logout);
  }
}

checkLogin(CheckLoginEvent event, Emitter<LoginState> emit) async {
  final user = await LocalStorage.getUserData();
  user.id.isEmpty ? emit(const LoginInitial()) : emit(const LoggedInState());
}

logout(LogoutButtonPressed event, Emitter<LoginState> emit) async {
  await LocalStorage.clearUserData();
  emit(const LoggedOutState());

  Fluttertoast.showToast(msg: 'Logged out successfully');
}
