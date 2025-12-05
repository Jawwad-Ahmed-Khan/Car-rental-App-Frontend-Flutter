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
        id: 1,
        brand: 'Toyota',
        model: 'Camry',
        year: 2023,
        price: 50.0,
        imageUrl: 'assets/images/camry.png',
        rating: 4.5,
        seats: 5,
        transmission: 'Automatic',
        fuelType: 'Petrol',
        status: 'available',
        isFavorite: false,
      ),
      CarModel(
        id: 2,
        brand: 'Honda',
        model: 'Civic',
        year: 2022,
        price: 45.0,
        imageUrl: 'assets/images/civic.png',
        rating: 4.2,
        seats: 5,
        transmission: 'Automatic',
        fuelType: 'Petrol',
        status: 'available',
        isFavorite: true,
      ),
      CarModel(
        id: 3,
        brand: 'BMW',
        model: 'X5',
        year: 2023,
        price: 120.0,
        imageUrl: 'assets/images/x5.png',
        rating: 4.8,
        seats: 5,
        transmission: 'Automatic',
        fuelType: 'Diesel',
        status: 'available',
        isFavorite: false,
      ),
      CarModel(
        id: 4,
        brand: 'Audi',
        model: 'A4',
        year: 2022,
        price: 80.0,
        imageUrl: 'assets/images/a4.png',
        rating: 4.6,
        seats: 5,
        transmission: 'Automatic',
        fuelType: 'Petrol',
        status: 'available',
        isFavorite: false,
      ),
      CarModel(
        id: 5,
        brand: 'Mercedes',
        model: 'C-Class',
        year: 2023,
        price: 100.0,
        imageUrl: 'assets/images/c_class.png',
        rating: 4.7,
        seats: 5,
        transmission: 'Automatic',
        fuelType: 'Petrol',
        status: 'available',
        isFavorite: true,
      ),
    ];
  }
}
