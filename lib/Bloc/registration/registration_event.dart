part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationButtonPressed extends RegistrationEvent {
  final String username;
  final String email;
  final String password;
  final String profileImagePath;

  const RegistrationButtonPressed({
    required this.username,
    required this.email,
    required this.password,
    required this.profileImagePath,
  });

  @override
  List<Object> get props => [username, email, password, profileImagePath];
}

class VerifyEmailButtonPressed extends RegistrationEvent {
  final String email;
  final int otp;

  const VerifyEmailButtonPressed({required this.email, required this.otp});

  @override
  List<Object> get props => [email, otp];
}

class GoogleSignInButtonPressed extends RegistrationEvent {
  // You can add any additional parameters needed for Google Sign-In
  const GoogleSignInButtonPressed();

  @override
  List<Object> get props => [];
}
