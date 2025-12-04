import '../../../home/domain/entities/car.dart';
import '../repositories/search_repository.dart';

/// Use case for filtering cars by brand
class GetCarsByBrand {
  final SearchRepository repository;

  GetCarsByBrand(this.repository);

  /// Returns all cars if brand is null, otherwise filters by brand
  Future<List<Car>> call(String? brand) async {
    return await repository.getCarsByBrand(brand);
  }
}
