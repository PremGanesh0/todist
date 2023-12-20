part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  late final String username;
  late final String email;

  RegistrationState({required this.username, required this.email});

  @override
  List<Object> get props => [username, email];
}

class RegistrationInitial extends RegistrationState {
  RegistrationInitial({required String username, required String email})
      : super(username: username, email: email);
}

class RegistrationLoading extends RegistrationState {
  RegistrationLoading({required super.username, required super.email});
}

class VerifyEmail extends RegistrationState {
  final bool requireEmailVerification; // New flag

  VerifyEmail({
    this.requireEmailVerification = false, // Default to false
    required String username,
    required String email,
  }) : super(username: username, email: email);
}

class RegistrationSuccess extends RegistrationState {
  var email;
  var username;

  RegistrationSuccess({
    required this.email,
    required this.username,
  }) : super(username: username, email: email);
}

class RegistrationFailure extends RegistrationState {
  final String error;

  RegistrationFailure({
    required this.error,
    required String username,
    required String email,
  }) : super(username: username, email: email);

  @override
  List<Object> get props => [error];
}

class VerifyEmailFailed extends RegistrationState {
  String error;
  VerifyEmailFailed({required this.error}) : super(username: '', email: '');
}

class VerifyEmailLoading extends RegistrationState {
  VerifyEmailLoading({required super.username, required super.email});
}
