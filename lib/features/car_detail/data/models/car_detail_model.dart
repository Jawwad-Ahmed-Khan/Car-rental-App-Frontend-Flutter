import '../../domain/entities/car_detail.dart';
import '../../domain/entities/owner.dart';

class CarDetailModel extends CarDetail {
  const CarDetailModel({
    required super.id,
    required super.brand,
    required super.model,
    required super.price,
    required super.imageUrls,
    required super.rating,
    required super.reviewCount,
    required super.description,
    required super.seats,
    super.isFavorite,
    required super.owner,
    required super.features,
    required super.reviews,
  });

  factory CarDetailModel.fromJson(Map<String, dynamic> json) {
    // Map images
    List<String> images = [];
    if (json['images'] != null) {
      images = (json['images'] as List)
          .map((img) => img['url'] as String)
          .toList();
    } else if (json['coverImageUrl'] != null) {
      images.add(json['coverImageUrl']);
    }

    // Map Owner (Fleet Manager)
    final owner = Owner(
      id: '5', // Hardcoded for now as backend doesn't return FM ID in public list
      name: json['fleetManagerName'] ?? 'Unknown Manager',
      avatarUrl: 'assets/images/user.png', // Placeholder
      isVerified: true,
    );

    return CarDetailModel(
      id: json['id'].toString(),
      brand: json['make'] ?? '',
      model: json['model'] ?? '',
      price: (json['selfDriveBaseRate'] != null)
          ? double.tryParse(json['selfDriveBaseRate'].toString()) ?? 0.0
          : 0.0,
      imageUrls: images,
      rating: 0.0, // Not in backend
      reviewCount: 0, // Not in backend
      description:
          '${json['make']} ${json['model']} ${json['year']}. Color: ${json['color']}. Transmission: ${json['transmissionType']}.',
      seats: json['seatingCapacity'] ?? 4,
      isFavorite: false,
      owner: owner,
      features: [], // Not in backend response yet
      reviews: [], // Not in backend response yet
    );
  }
}
