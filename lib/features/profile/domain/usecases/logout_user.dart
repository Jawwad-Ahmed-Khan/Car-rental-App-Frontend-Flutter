import 'package:dartz/dartz.dart';
import '../repositories/profile_repository.dart';

/// Use case to log out user and clear SharedPreferences
class LogoutUser {
  final ProfileRepository repository;

  LogoutUser(this.repository);

  Future<Either<Exception, void>> call() async {
    return await repository.logout();
  }
}
