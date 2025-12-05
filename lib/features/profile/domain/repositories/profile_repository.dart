import 'package:dartz/dartz.dart';
import '../../../auth/domain/entities/user.dart';

/// Repository interface for profile-related operations
abstract class ProfileRepository {
  /// Get the current logged-in user profile
  Future<Either<Exception, User?>> getUserProfile();

  /// Save user profile to local storage
  Future<Either<Exception, void>> saveUserProfile(User user);

  /// Log out the current user
  Future<Either<Exception, void>> logout();

  /// Check if user is logged in
  Future<bool> isLoggedIn();

  /// Get favorite car IDs
  Future<List<String>> getFavoriteCarIds();

  /// Add car to favorites
  Future<void> addFavorite(String carId);

  /// Remove car from favorites
  Future<void> removeFavorite(String carId);

  /// Check if car is favorite
  Future<bool> isFavorite(String carId);
}
