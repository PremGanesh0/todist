part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  late final String username;
  late final String email;
  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {
  late final String username;
  late final String email;
  RegistrationSuccess({required this.email, required this.username});
}

class VerifyEmail extends RegistrationState {
  final bool requireEmailVerification; // New flag

  VerifyEmail({
    this.requireEmailVerification = false, // Default to false
  });
}

class RegistrationFailure extends RegistrationState {
  final String error;

  RegistrationFailure({required this.error});

  @override
  List<Object> get props => [error];
}
