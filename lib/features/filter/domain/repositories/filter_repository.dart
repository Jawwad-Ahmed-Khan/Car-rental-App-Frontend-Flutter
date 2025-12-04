import '../../../home/domain/entities/car.dart';
import '../entities/filter_criteria.dart';

/// Repository interface for filter operations
abstract class FilterRepository {
  /// Apply filter criteria to get filtered cars
  Future<List<Car>> applyFilters(FilterCriteria criteria);

  /// Get the count of cars matching the filter criteria
  Future<int> getFilteredCarsCount(FilterCriteria criteria);
}
