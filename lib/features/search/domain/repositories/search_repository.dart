import '../../../home/domain/entities/car.dart';

/// Abstract repository for search feature
abstract class SearchRepository {
  /// Search cars by query string
  Future<List<Car>> searchCars(String query);

  /// Get cars filtered by brand (null returns all cars)
  Future<List<Car>> getCarsByBrand(String? brand);

  /// Get recommended cars for the user
  Future<List<Car>> getRecommendedCars();

  /// Get popular cars
  Future<List<Car>> getPopularCars();
}
