import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/car_detail.dart';
import '../../domain/repositories/car_detail_repository.dart';
import '../datasources/car_detail_remote_data_source.dart';

class CarDetailRepositoryImpl implements CarDetailRepository {
  final CarDetailRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CarDetailRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<CarDetail> getCarDetails(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCarDetail = await remoteDataSource.getCarDetails(id);
        return remoteCarDetail;
      } catch (e) {
        throw ServerFailure('Failed to fetch car details');
      }
    } else {
      throw ServerFailure('No internet connection');
    }
  }
}
