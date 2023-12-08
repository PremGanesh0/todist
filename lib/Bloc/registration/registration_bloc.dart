import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todist/Bloc/registration/api.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<RegistrationButtonPressed>(registerApi);
    on<VerifyEmailButtonPressed>(verifyEmail);
  }
}
