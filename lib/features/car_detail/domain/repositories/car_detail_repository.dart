import '../entities/car_detail.dart';

/// Repository interface for car details
abstract class CarDetailRepository {
  /// Get car details by car ID
  Future<CarDetail> getCarDetails(String carId);
}
