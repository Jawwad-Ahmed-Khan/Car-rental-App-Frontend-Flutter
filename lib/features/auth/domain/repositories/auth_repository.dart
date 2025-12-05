import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

/// Abstract repository contract for authentication
abstract class AuthRepository {
  /// Login with email and password
  Future<Either<Failure, User>> login(String email, String password);

  /// Register new user
  Future<Either<Failure, User>> register(
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
  );

  /// Logout current user
  Future<Either<Failure, void>> logout();

  /// Get current user from cache
  Future<Either<Failure, User>> getCurrentUser();
}
