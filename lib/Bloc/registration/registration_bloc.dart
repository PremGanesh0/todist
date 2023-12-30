import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todist/Api/registration_api.dart';
import 'package:todist/api/google_login.dart';
import 'package:todist/api/verify_api.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(const RegistrationInitial(username: '', email: '')) {
    on<RegistrationButtonPressed>(registerApi);
    on<VerifyEmailButtonPressed>(verifyEmail);
    on<GoogleSignInButtonPressed>(googleSignIn);
  }
}
