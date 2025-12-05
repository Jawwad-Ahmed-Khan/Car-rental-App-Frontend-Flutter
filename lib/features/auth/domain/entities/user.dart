import 'package:equatable/equatable.dart';

/// User entity representing business domain user
class User extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? photoUrl;
  final String? accessToken;

  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.photoUrl,
    this.accessToken,
  });

  @override
  List<Object?> get props => [
    id,
    email,
    firstName,
    lastName,
    phoneNumber,
    photoUrl,
    accessToken,
  ];
}
