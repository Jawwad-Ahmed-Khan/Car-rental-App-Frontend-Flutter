import '../entities/car_detail.dart';
import '../repositories/car_detail_repository.dart';

/// Use case for getting car details
class GetCarDetails {
  final CarDetailRepository repository;

  GetCarDetails(this.repository);

  Future<CarDetail> call(String carId) async {
    return await repository.getCarDetails(carId);
  }
}
