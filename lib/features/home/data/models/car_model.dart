import '../../domain/entities/car.dart';

class CarModel extends Car {
  CarModel({
    required super.id,
    required super.brand,
    required super.model,
    required super.price,
    required super.imageUrl,
    required super.rating,
    required super.seats,
    super.isFavorite,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      brand: json['brand'],
      model: json['model'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
      rating: (json['rating'] as num).toDouble(),
      seats: json['seats'] ?? 4,
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'price': price,
      'imageUrl': imageUrl,
      'rating': rating,
      'seats': seats,
      'isFavorite': isFavorite,
    };
  }
}
