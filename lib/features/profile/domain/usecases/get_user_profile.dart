import 'package:dartz/dartz.dart';
import '../../../auth/domain/entities/user.dart';
import '../repositories/profile_repository.dart';

/// Use case to fetch current user profile from SharedPreferences
class GetUserProfile {
  final ProfileRepository repository;

  GetUserProfile(this.repository);

  Future<Either<Exception, User?>> call() async {
    return await repository.getUserProfile();
  }
}
