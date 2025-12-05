import '../entities/review.dart';
import '../repositories/reviews_repository.dart';

/// Use case to search reviews by query
class SearchReviews {
  final ReviewsRepository repository;

  SearchReviews(this.repository);

  /// Execute the use case
  Future<List<Review>> call(String carId, String query) async {
    return await repository.searchReviews(carId, query);
  }
}
