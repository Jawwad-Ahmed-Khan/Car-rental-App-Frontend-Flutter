import 'owner.dart';
import 'car_feature.dart';
import 'review.dart';

/// CarDetail entity with complete car information
class CarDetail {
  final String id;
  final String brand;
  final String model;
  final double price;
  final List<String> imageUrls;
  final double rating;
  final int reviewCount;
  final String description;
  final int seats;
  final bool isFavorite;
  final Owner owner;
  final List<CarFeature> features;
  final List<Review> reviews;

  const CarDetail({
    required this.id,
    required this.brand,
    required this.model,
    required this.price,
    required this.imageUrls,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.seats,
    this.isFavorite = false,
    required this.owner,
    required this.features,
    required this.reviews,
  });
}
