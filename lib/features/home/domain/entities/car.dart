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
}
