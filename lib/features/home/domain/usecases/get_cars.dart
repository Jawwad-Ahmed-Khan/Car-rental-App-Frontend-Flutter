import '../entities/car.dart';
import '../repositories/home_repository.dart';

class GetCars {
  final HomeRepository repository;

  GetCars(this.repository);

  Future<List<Car>> call() async {
    return await repository.getCars();
  }
}
