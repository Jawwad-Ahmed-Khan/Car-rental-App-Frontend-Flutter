import '../entities/review.dart';
import '../repositories/reviews_repository.dart';

/// Use case to get all reviews for a car
class GetReviews {
  final ReviewsRepository repository;

  GetReviews(this.repository);

  /// Execute the use case
  Future<List<Review>> call(String carId) async {
    return await repository.getReviews(carId);
  }
}
