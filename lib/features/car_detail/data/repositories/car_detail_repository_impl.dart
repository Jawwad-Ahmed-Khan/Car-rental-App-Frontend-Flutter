import '../../domain/entities/car_detail.dart';
import '../../domain/repositories/car_detail_repository.dart';
import '../datasources/car_detail_local_data_source.dart';

/// Implementation of CarDetailRepository using local data source
class CarDetailRepositoryImpl implements CarDetailRepository {
  final CarDetailLocalDataSource localDataSource;

  CarDetailRepositoryImpl({required this.localDataSource});

  @override
  Future<CarDetail> getCarDetails(String carId) async {
    return await localDataSource.getCarDetails(carId);
  }
}
