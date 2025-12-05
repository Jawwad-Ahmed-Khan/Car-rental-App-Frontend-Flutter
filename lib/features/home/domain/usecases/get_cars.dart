import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/car.dart';
import '../repositories/home_repository.dart';

class GetCars {
  final HomeRepository repository;

  GetCars(this.repository);

  Future<Either<Failure, List<Car>>> call() async {
    return await repository.getCars();
  }
}
