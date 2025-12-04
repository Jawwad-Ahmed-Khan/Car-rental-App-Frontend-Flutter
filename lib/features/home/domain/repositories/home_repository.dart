import '../entities/car.dart';

abstract class HomeRepository {
  Future<List<Car>> getCars();
}
