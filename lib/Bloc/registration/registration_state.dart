part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  final String username;
  final String email;

  const RegistrationState({required this.username, required this.email});

  @override
  List<Object> get props => [username, email];
}

class RegistrationInitial extends RegistrationState {
  const RegistrationInitial({required String username, required String email})
      : super(username: username, email: email);
}

class RegistrationLoading extends RegistrationState {
  const RegistrationLoading({required super.username, required super.email});
}

class VerifyEmail extends RegistrationState {
  final bool requireEmailVerification; // New flag

  const VerifyEmail({
    this.requireEmailVerification = false, // Default to false
    required String username,
    required String email,
  }) : super(username: username, email: email);
}

class RegistrationSuccess extends RegistrationState {
  const RegistrationSuccess({required String username, required String email})
      : super(username: username, email: email);
}

class RegistrationFailure extends RegistrationState {
  final String error;

  const RegistrationFailure({
    required this.error,
    required String username,
    required String email,
  }) : super(username: username, email: email);

  @override
  List<Object> get props => [error];
}

class VerifyEmailFailed extends RegistrationState {
  final String error;
  const VerifyEmailFailed({required this.error}) : super(username: '', email: '');
}

class VerifyEmailLoading extends RegistrationState {
  const VerifyEmailLoading({required super.username, required super.email});
}
