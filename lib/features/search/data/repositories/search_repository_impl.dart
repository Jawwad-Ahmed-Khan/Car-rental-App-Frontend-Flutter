import '../../../home/domain/entities/car.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_local_data_source.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchLocalDataSource localDataSource;

  SearchRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Car>> searchCars(String query) async {
    return await localDataSource.searchCars(query);
  }

  @override
  Future<List<Car>> getCarsByBrand(String? brand) async {
    return await localDataSource.getCarsByBrand(brand);
  }

  @override
  Future<List<Car>> getRecommendedCars() async {
    return await localDataSource.getRecommendedCars();
  }

  @override
  Future<List<Car>> getPopularCars() async {
    return await localDataSource.getPopularCars();
  }
}
