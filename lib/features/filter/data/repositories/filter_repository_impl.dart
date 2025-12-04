import '../../../home/domain/entities/car.dart';
import '../../../search/data/datasources/search_local_data_source.dart';
import '../../domain/entities/filter_criteria.dart';
import '../../domain/repositories/filter_repository.dart';

/// Implementation of FilterRepository using local data source
class FilterRepositoryImpl implements FilterRepository {
  final SearchLocalDataSource dataSource;

  FilterRepositoryImpl({required this.dataSource});

  @override
  Future<List<Car>> applyFilters(FilterCriteria criteria) async {
    final allCars = await dataSource.getAllCars();
    
    return allCars.where((car) {
      // Filter by car type (luxury brands: Ferrari, Lamborghini)
      if (criteria.carType == CarType.luxuryCars) {
        final luxuryBrands = ['Ferrari', 'Lamborghini'];
        if (!luxuryBrands.contains(car.brand)) {
          return false;
        }
      } else if (criteria.carType == CarType.regularCars) {
        final luxuryBrands = ['Ferrari', 'Lamborghini'];
        if (luxuryBrands.contains(car.brand)) {
          return false;
        }
      }

      // Filter by price range
      if (car.price < criteria.minPrice || car.price > criteria.maxPrice) {
        return false;
      }

      // Filter by seating capacity
      if (criteria.seatingCapacity != null && car.seats != criteria.seatingCapacity) {
        return false;
      }

      return true;
    }).toList();
  }

  @override
  Future<int> getFilteredCarsCount(FilterCriteria criteria) async {
    final filteredCars = await applyFilters(criteria);
    return filteredCars.length;
  }
}
