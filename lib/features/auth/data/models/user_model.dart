import '../../domain/entities/user.dart';

/// Data Transfer Object for User
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
    super.photoUrl,
    super.accessToken,
  });

  /// Create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      email: json['email'] as String? ?? '',
      firstName:
          json['firstName'] as String? ?? json['first_name'] as String? ?? '',
      lastName:
          json['lastName'] as String? ?? json['last_name'] as String? ?? '',
      phoneNumber:
          json['contact'] as String? ?? json['phoneNumber'] as String? ?? '',
      photoUrl:
          json['profilePic'] as String? ?? json['profile_pic'] as String? ?? '',
      accessToken:
          json['token'] as String? ?? json['access_token'] as String? ?? '',
    );
  }

  /// Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'contact': phoneNumber,
      'profilePic': photoUrl,
      'token': accessToken,
    };
  }

  /// Create UserModel from User entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      phoneNumber: user.phoneNumber,
      photoUrl: user.photoUrl,
      accessToken: user.accessToken,
    );
  }
}
