import '../../../home/domain/entities/car.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_remote_data_source.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Car>> searchCars(String query) async {
    final cars = await remoteDataSource.fetchCars();
    if (query.isEmpty) return cars;

    final lowercaseQuery = query.toLowerCase();
    return cars.where((car) {
      return car.model.toLowerCase().contains(lowercaseQuery) ||
          car.brand.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  @override
  Future<List<Car>> getCarsByBrand(String? brand) async {
    final cars = await remoteDataSource.fetchCars();
    if (brand == null || brand == 'All') return cars;

    return cars.where((car) => car.brand == brand).toList();
  }

  @override
  Future<List<Car>> getRecommendedCars() async {
    final cars = await remoteDataSource.fetchCars();
    // Simple recommendation logic: return first 5 cars
    return cars.take(5).toList();
  }

  @override
  Future<List<Car>> getPopularCars() async {
    final cars = await remoteDataSource.fetchCars();
    // Simple popular logic: return cars with high rating
    return cars.where((car) => car.rating >= 4.5).take(5).toList();
  }
}
