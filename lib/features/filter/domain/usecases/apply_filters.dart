import '../../../home/domain/entities/car.dart';
import '../entities/filter_criteria.dart';
import '../repositories/filter_repository.dart';

/// Use case for applying filters to car search
class ApplyFilters {
  final FilterRepository repository;

  ApplyFilters(this.repository);

  /// Execute the use case with given filter criteria
  Future<List<Car>> call(FilterCriteria criteria) async {
    return repository.applyFilters(criteria);
  }
}

/// Use case for getting count of filtered cars
class GetFilteredCarsCount {
  final FilterRepository repository;

  GetFilteredCarsCount(this.repository);

  /// Execute the use case with given filter criteria
  Future<int> call(FilterCriteria criteria) async {
    return repository.getFilteredCarsCount(criteria);
  }
}
