import '../models/car_model.dart';

abstract class HomeLocalDataSource {
  Future<List<CarModel>> getCars();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<List<CarModel>> getCars() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return [
      CarModel(
        id: '1',
        brand: 'Ferrari',
        model: 'Ferrari-FF',
        price: 200,
        imageUrl: 'assets/images/ferrari_car_1.webp',
        rating: 5.0,
        seats: 4,
      ),
      CarModel(
        id: '2',
        brand: 'Tesla',
        model: 'Tesla Model S',
        price: 100,
        imageUrl: 'assets/images/Tesla_car_2.png',
        rating: 5.0,
        seats: 5,
      ),
      CarModel(
        id: '3',
        brand: 'BMW',
        model: 'BMW i8',
        price: 150,
        imageUrl: 'assets/images/Tesla_car_2.png', // Fallback
        rating: 4.8,
        seats: 2,
      ),
      CarModel(
        id: '4',
        brand: 'Lamborghini',
        model: 'Huracan',
        price: 300,
        imageUrl: 'assets/images/Tesla_car_2.png', // Fallback
        rating: 4.9,
        seats: 2,
      ),
      CarModel(
        id: '5',
        brand: 'Toyota',
        model: 'Camry',
        price: 50,
        imageUrl: 'assets/images/toyota_car_1.jpg',
        rating: 4.5,
        seats: 5,
      ),
    ];
  }
}
