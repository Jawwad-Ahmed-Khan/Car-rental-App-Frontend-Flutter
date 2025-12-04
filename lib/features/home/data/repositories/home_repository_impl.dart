import '../../domain/entities/car.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Car>> getCars() async {
    return await localDataSource.getCars();
  }

}
