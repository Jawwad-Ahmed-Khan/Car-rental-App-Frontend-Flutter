import '../../domain/entities/review.dart';
import '../../domain/repositories/reviews_repository.dart';
import '../datasources/reviews_local_data_source.dart';

/// Implementation of ReviewsRepository
/// Uses local data source for now, will switch to remote in future
class ReviewsRepositoryImpl implements ReviewsRepository {
  final ReviewsLocalDataSource localDataSource;

  ReviewsRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Review>> getReviews(String carId) async {
    return await localDataSource.getReviews(carId);
  }

  @override
  Future<List<Review>> searchReviews(String carId, String query) async {
    return await localDataSource.searchReviews(carId, query);
  }
}
