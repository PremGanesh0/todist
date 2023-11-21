// registration_event.dart

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
