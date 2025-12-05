import '../entities/review.dart';

/// Repository interface for reviews
abstract class ReviewsRepository {
  /// Get all reviews for a specific car
  Future<List<Review>> getReviews(String carId);

  /// Search reviews by query
  Future<List<Review>> searchReviews(String carId, String query);
}
