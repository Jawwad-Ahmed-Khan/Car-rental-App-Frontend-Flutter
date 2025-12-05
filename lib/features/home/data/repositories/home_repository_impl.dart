import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/car.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Car>>> getCars() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCars = await remoteDataSource.fetchCars();
        return Right(remoteCars);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Car>> getCarDetails(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCar = await remoteDataSource.fetchCarDetails(id);
        return Right(remoteCar);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure('No internet connection'));
    }
  }
}
