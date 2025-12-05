import '../../domain/entities/car.dart';

class CarModel extends Car {
  CarModel({
    required super.id,
    required super.brand,
    required super.model,
    required super.year,
    required super.price,
    required super.imageUrl,
    required super.rating,
    required super.seats,
    required super.transmission,
    required super.fuelType,
    required super.status,
    super.isFavorite,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] as int,
      brand: json['make'] ?? '',
      model: json['model'] ?? '',
      year: json['year'] ?? 0,
      price: (json['selfDriveBaseRate'] != null)
          ? double.tryParse(json['selfDriveBaseRate'].toString()) ?? 0.0
          : 0.0,
      imageUrl: json['coverImageUrl'] ?? '',
      rating: 0.0, // Backend doesn't return rating yet
      seats: json['seatingCapacity'] ?? 4,
      transmission: json['transmissionType'] ?? 'Automatic',
      fuelType: json['fuelType'] ?? 'Petrol',
      status: json['vehicleStatus'] ?? 'available',
      isFavorite: false, // Backend public list doesn't return favorite status
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'make': brand,
      'model': model,
      'year': year,
      'selfDriveBaseRate': price,
      'coverImageUrl': imageUrl,
      'seatingCapacity': seats,
      'transmissionType': transmission,
      'fuelType': fuelType,
      'vehicleStatus': status,
    };
  }
}
