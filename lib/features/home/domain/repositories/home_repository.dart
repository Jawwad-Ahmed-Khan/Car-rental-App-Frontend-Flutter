import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/car.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Car>>> getCars();
  Future<Either<Failure, Car>> getCarDetails(int id);
}
