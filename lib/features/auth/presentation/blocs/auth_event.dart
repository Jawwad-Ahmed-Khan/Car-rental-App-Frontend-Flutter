part of 'auth_bloc.dart';

/// Base authentication event
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

/// Login event
class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

/// Register event
class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;

  const RegisterEvent({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [email, password, firstName, lastName, phoneNumber];
}

/// Logout event
class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}
