import '../../domain/entities/review.dart';

/// Local data source for reviews with mock data
/// Uses existing dummy reviews that are shown for every car
/// In the future, this will be replaced with API calls
class ReviewsLocalDataSource {
  /// Mock reviews data matching the Figma design
  /// These reviews are shown for all cars until API is integrated
  final List<Review> _mockReviews = [
    Review(
      id: 'review1',
      authorName: 'Mr. Jack',
      authorAvatarUrl: 'assets/images/user_avatar.png',
      rating: 5.0,
      content:
          'The rental car was clean, reliable, and the service was quick and efficient. Overall, the experience was hassle-free and enjoyable.',
      createdAt: DateTime.now(),
    ),
    Review(
      id: 'review2',
      authorName: 'Robert',
      authorAvatarUrl: 'assets/images/user_avatar.png',
      rating: 5.0,
      content:
          'The rental car was clean, reliable, and the service was quick and efficient. Overall, the experience was hassle-free and enjoyable.',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Review(
      id: 'review3',
      authorName: 'Juliea',
      authorAvatarUrl: 'assets/images/user_avatar.png',
      rating: 5.0,
      content:
          'The rental car was clean, reliable, and the service was quick and efficient. Overall, the experience was hassle-free and enjoyable.',
      createdAt: DateTime.now().subtract(const Duration(days: 14)),
    ),
    Review(
      id: 'review4',
      authorName: 'Mr. Jon',
      authorAvatarUrl: 'assets/images/user_avatar.png',
      rating: 5.0,
      content:
          'The rental car was clean, reliable, and the service was quick and efficient. Overall, the experience was hassle-free and enjoyable.',
      createdAt: DateTime.now().subtract(const Duration(days: 21)),
    ),
    Review(
      id: 'review5',
      authorName: 'Hanrick',
      authorAvatarUrl: 'assets/images/user_avatar.png',
      rating: 3.0,
      content:
          'The rental car was clean, reliable, and the service was quick and efficient. Overall, the experience was hassle-free and enjoyable.',
      createdAt: DateTime.now().subtract(const Duration(days: 21)),
    ),
  ];

  /// Get all reviews for a car
  /// Currently returns dummy data for all cars
  Future<List<Review>> getReviews(String carId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockReviews;
  }

  /// Search reviews by query
  Future<List<Review>> searchReviews(String carId, String query) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    if (query.isEmpty) {
      return _mockReviews;
    }

    final lowerQuery = query.toLowerCase();
    return _mockReviews.where((review) {
      return review.authorName.toLowerCase().contains(lowerQuery) ||
          review.content.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
