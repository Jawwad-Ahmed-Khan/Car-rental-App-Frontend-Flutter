class Car {
  final String id;
  final String brand;
  final String model;
  final double price;
  final String imageUrl;
  final double rating;
  final int seats;
  final bool isFavorite;

  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.seats,
    this.isFavorite = false,
  });
}
