import '../../../home/data/models/car_model.dart';

/// Abstract data source for search feature
abstract class SearchLocalDataSource {
  /// Get all searchable cars
  Future<List<CarModel>> getAllCars();

  /// Search cars by query
  Future<List<CarModel>> searchCars(String query);

  /// Get cars by brand
  Future<List<CarModel>> getCarsByBrand(String? brand);

  /// Get recommended cars
  Future<List<CarModel>> getRecommendedCars();

  /// Get popular cars
  Future<List<CarModel>> getPopularCars();
}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  // Mock data with dummy prices, ratings, locations
  final List<CarModel> _allCars = [
    CarModel(
      id: 1,
      brand: 'Tesla',
      model: 'Tesla Model S',
      year: 2023,
      price: 100,
      imageUrl: 'assets/images/Tesla_car_1.avif',
      rating: 5.0,
      seats: 5,
      transmission: 'Automatic',
      fuelType: 'Electric',
      status: 'available',
      isFavorite: false,
    ),
    CarModel(
      id: 2,
      brand: 'Ferrari',
      model: 'Ferrari LaFerrari',
      year: 2023,
      price: 100,
      imageUrl: 'assets/images/ferrari_car_1.webp',
      rating: 5.0,
      seats: 2,
      transmission: 'Automatic',
      fuelType: 'Petrol',
      status: 'available',
      isFavorite: false,
    ),
    CarModel(
      id: 3,
      brand: 'Lamborghini',
      model: 'Lamborghini Aventador',
      year: 2023,
      price: 100,
      imageUrl: 'assets/images/lamborghini_car_1.avif',
      rating: 4.9,
      seats: 2,
      transmission: 'Automatic',
      fuelType: 'Petrol',
      status: 'available',
      isFavorite: false,
    ),
    CarModel(
      id: 4,
      brand: 'BMW',
      model: 'BMW GTS3 M2',
      year: 2023,
      price: 100,
      imageUrl: 'assets/images/Bmw_car_1.avif',
      rating: 5.0,
      seats: 4,
      transmission: 'Automatic',
      fuelType: 'Petrol',
      status: 'available',
      isFavorite: false,
    ),
    CarModel(
      id: 5,
      brand: 'Ferrari',
      model: 'Ferrari LaFerrari',
      year: 2023,
      price: 100,
      imageUrl: 'assets/images/ferrari_car_2.webp',
      rating: 5.0,
      seats: 2,
      transmission: 'Automatic',
      fuelType: 'Petrol',
      status: 'available',
      isFavorite: false,
    ),
    CarModel(
      id: 6,
      brand: 'BMW',
      model: 'BMW i8',
      year: 2023,
      price: 120,
      imageUrl: 'assets/images/Bmw_car_2.avif',
      rating: 4.8,
      seats: 2,
      transmission: 'Automatic',
      fuelType: 'Hybrid',
      status: 'available',
      isFavorite: false,
    ),
    CarModel(
      id: 7,
      brand: 'Tesla',
      model: 'Tesla Model X',
      year: 2023,
      price: 150,
      imageUrl: 'assets/images/Tesla_car_2.png',
      rating: 4.9,
      seats: 7,
      transmission: 'Automatic',
      fuelType: 'Electric',
      status: 'available',
      isFavorite: false,
    ),
    CarModel(
      id: 8,
      brand: 'Lamborghini',
      model: 'Lamborghini Huracan',
      year: 2023,
      price: 200,
      imageUrl: 'assets/images/lamborghini_car_2.webp',
      rating: 5.0,
      seats: 2,
      transmission: 'Automatic',
      fuelType: 'Petrol',
      status: 'available',
      isFavorite: false,
    ),
  ];

  // Dummy locations for cars
  final List<String> _locations = [
    'Chicago, USA',
    'Washington DC',
    'Washington DC',
    'New York, USA',
    'Los Angeles, USA',
    'Miami, USA',
    'San Francisco, USA',
    'Boston, USA',
  ];

  String getLocationForCar(int index) {
    return _locations[index % _locations.length];
  }

  @override
  Future<List<CarModel>> getAllCars() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _allCars;
  }

  @override
  Future<List<CarModel>> searchCars(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (query.isEmpty) {
      return _allCars;
    }
    final lowerQuery = query.toLowerCase();
    return _allCars.where((car) {
      return car.model.toLowerCase().contains(lowerQuery) ||
          car.brand.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  @override
  Future<List<CarModel>> getCarsByBrand(String? brand) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (brand == null || brand.isEmpty || brand.toUpperCase() == 'ALL') {
      return _allCars;
    }
    return _allCars.where((car) {
      return car.brand.toLowerCase() == brand.toLowerCase();
    }).toList();
  }

  @override
  Future<List<CarModel>> getRecommendedCars() async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Return first 4 cars as recommended
    return _allCars.take(4).toList();
  }

  @override
  Future<List<CarModel>> getPopularCars() async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Return last 4 cars as popular
    return _allCars.skip(4).take(4).toList();
  }
}
