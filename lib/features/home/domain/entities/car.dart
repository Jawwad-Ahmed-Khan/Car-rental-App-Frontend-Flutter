class Car {
  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.seats,
    required this.transmission,
    required this.fuelType,
    required this.status,
    this.isFavorite = false,
  });

  final int id; // Changed to int to match backend
  final String brand;
  final String model;
  final int year;
  final double price;
  final String imageUrl;
  final double rating;
  final int seats;
  final String transmission;
  final String fuelType;
  final String status;
  final bool isFavorite;

  Car copyWith({
    int? id,
    String? brand,
    String? model,
    int? year,
    double? price,
    String? imageUrl,
    double? rating,
    int? seats,
    String? transmission,
    String? fuelType,
    String? status,
    bool? isFavorite,
  }) {
    return Car(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      seats: seats ?? this.seats,
      transmission: transmission ?? this.transmission,
      fuelType: fuelType ?? this.fuelType,
      status: status ?? this.status,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
