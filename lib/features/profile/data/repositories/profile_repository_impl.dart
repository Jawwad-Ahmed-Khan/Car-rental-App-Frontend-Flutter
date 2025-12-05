import 'package:dartz/dartz.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_data_source.dart';

/// Implementation of ProfileRepository using local data source
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Exception, User?>> getUserProfile() async {
    try {
      final user = await localDataSource.getUser();
      return Right(user);
    } catch (e) {
      return Left(Exception('Failed to get user profile: $e'));
    }
  }

  @override
  Future<Either<Exception, void>> saveUserProfile(User user) async {
    try {
      await localDataSource.saveUser(user);
      return const Right(null);
    } catch (e) {
      return Left(Exception('Failed to save user profile: $e'));
    }
  }

  @override
  Future<Either<Exception, void>> logout() async {
    try {
      await localDataSource.clearUser();
      return const Right(null);
    } catch (e) {
      return Left(Exception('Failed to logout: $e'));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return await localDataSource.isLoggedIn();
  }

  @override
  Future<List<String>> getFavoriteCarIds() async {
    return await localDataSource.getFavoriteCarIds();
  }

  @override
  Future<void> addFavorite(String carId) async {
    await localDataSource.addFavorite(carId);
  }

  @override
  Future<void> removeFavorite(String carId) async {
    await localDataSource.removeFavorite(carId);
  }

  @override
  Future<bool> isFavorite(String carId) async {
    return await localDataSource.isFavorite(carId);
  }
}
