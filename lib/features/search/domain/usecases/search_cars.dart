import '../../../home/domain/entities/car.dart';
import '../repositories/search_repository.dart';

/// Use case for searching cars by query
class SearchCars {
  final SearchRepository repository;

  SearchCars(this.repository);

  Future<List<Car>> call(String query) async {
    return await repository.searchCars(query);
  }
}
