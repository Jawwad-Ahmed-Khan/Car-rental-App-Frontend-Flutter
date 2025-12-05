import 'package:flutter/material.dart';
import '../../domain/entities/car_detail.dart';
import '../../domain/entities/owner.dart';
import '../../domain/entities/car_feature.dart';
import '../../domain/entities/review.dart';

/// Local data source for car details with mock data
class CarDetailLocalDataSource {
  /// Mock car details data - matches home page car IDs
  final Map<String, CarDetail> _mockCarDetails = {
    '1': CarDetail(
      id: '1',
      brand: 'Ferrari',
      model: 'Ferrari-FF',
      price: 200,
      imageUrls: [
        'assets/images/ferrari_car_1.webp',
        'assets/images/ferrari_car_2.webp',
      ],
      rating: 5.0,
      reviewCount: 120,
      description: 'A stunning grand tourer with a powerful V12 engine and all-wheel drive for exceptional performance.',
      seats: 4,
      isFavorite: false,
      owner: const Owner(
        id: 'owner1',
        name: 'Hela Quintin',
        avatarUrl: 'assets/images/user_avatar.png',
        isVerified: true,
      ),
      features: const [
        CarFeature(
          icon: Icons.airline_seat_recline_normal,
          title: 'Capacity',
          value: '4 Seats',
        ),
        CarFeature(
          icon: Icons.speed,
          title: 'Engine Out',
          value: '660 HP',
        ),
        CarFeature(
          icon: Icons.speed_outlined,
          title: 'Max Speed',
          value: '335km/h',
        ),
        CarFeature(
          icon: Icons.auto_mode,
          title: 'Advance',
          value: 'Sport Mode',
        ),
        CarFeature(
          icon: Icons.local_gas_station,
          title: 'Fuel Tank',
          value: '91 Liters',
        ),
        CarFeature(
          icon: Icons.local_parking,
          title: 'Advance',
          value: 'Park Assist',
        ),
      ],
      reviews: const [
        Review(
          id: 'review1',
          authorName: 'Mr. Jack',
          authorAvatarUrl: 'assets/images/user_avatar.png',
          rating: 5.0,
          content: 'Absolutely incredible experience driving this beast!',
        ),
        Review(
          id: 'review2',
          authorName: 'Robert',
          authorAvatarUrl: 'assets/images/user_avatar.png',
          rating: 5.0,
          content: 'The V12 engine sound is music to my ears.',
        ),
      ],
    ),
    '2': CarDetail(
      id: '2',
      brand: 'Tesla',
      model: 'Tesla Model S',
      price: 100,
      imageUrls: [
        'assets/images/Tesla_car_2.png',
        'assets/images/car_banner.png',
      ],
      rating: 5.0,
      reviewCount: 100,
      description: 'A car with high specs that are rented at an affordable price.',
      seats: 5,
      isFavorite: false,
      owner: const Owner(
        id: 'owner2',
        name: 'John Smith',
        avatarUrl: 'assets/images/user_avatar.png',
        isVerified: true,
      ),
      features: const [
        CarFeature(
          icon: Icons.airline_seat_recline_normal,
          title: 'Capacity',
          value: '5 Seats',
        ),
        CarFeature(
          icon: Icons.speed,
          title: 'Engine Out',
          value: '670 HP',
        ),
        CarFeature(
          icon: Icons.speed_outlined,
          title: 'Max Speed',
          value: '250km/h',
        ),
        CarFeature(
          icon: Icons.auto_mode,
          title: 'Advance',
          value: 'Autopilot',
        ),
        CarFeature(
          icon: Icons.battery_charging_full,
          title: 'Single Charge',
          value: '405 Miles',
        ),
        CarFeature(
          icon: Icons.local_parking,
          title: 'Advance',
          value: 'Auto Parking',
        ),
      ],
      reviews: const [
        Review(
          id: 'review3',
          authorName: 'Sarah',
          authorAvatarUrl: 'assets/images/user_avatar.png',
          rating: 5.0,
          content: 'The rental car was clean, reliable, and the service was quick.',
        ),
        Review(
          id: 'review4',
          authorName: 'Mike',
          authorAvatarUrl: 'assets/images/user_avatar.png',
          rating: 4.5,
          content: 'Great car, amazing experience. Would rent again!',
        ),
      ],
    ),
    '3': CarDetail(
      id: '3',
      brand: 'BMW',
      model: 'BMW i8',
      price: 150,
      imageUrls: [
        'assets/images/toyota_car_2.png',
        'assets/images/car_banner.png',
      ],
      rating: 4.8,
      reviewCount: 85,
      description: 'A futuristic plug-in hybrid sports car with stunning design and impressive performance.',
      seats: 2,
      isFavorite: true,
      owner: const Owner(
        id: 'owner3',
        name: 'Emma Davis',
        avatarUrl: 'assets/images/user_avatar.png',
        isVerified: true,
      ),
      features: const [
        CarFeature(
          icon: Icons.airline_seat_recline_normal,
          title: 'Capacity',
          value: '2 Seats',
        ),
        CarFeature(
          icon: Icons.speed,
          title: 'Engine Out',
          value: '369 HP',
        ),
        CarFeature(
          icon: Icons.speed_outlined,
          title: 'Max Speed',
          value: '250km/h',
        ),
        CarFeature(
          icon: Icons.auto_mode,
          title: 'Advance',
          value: 'Sport Mode',
        ),
        CarFeature(
          icon: Icons.battery_charging_full,
          title: 'Electric Range',
          value: '37 Miles',
        ),
        CarFeature(
          icon: Icons.local_parking,
          title: 'Advance',
          value: 'Park Assist',
        ),
      ],
      reviews: const [
        Review(
          id: 'review5',
          authorName: 'Alex',
          authorAvatarUrl: 'assets/images/user_avatar.png',
          rating: 5.0,
          content: 'The design is absolutely stunning. Heads turn everywhere!',
        ),
        Review(
          id: 'review6',
          authorName: 'Lisa',
          authorAvatarUrl: 'assets/images/user_avatar.png',
          rating: 4.5,
          content: 'Loved the hybrid performance and the butterfly doors.',
        ),
      ],
    ),
    '4': CarDetail(
      id: '4',
      brand: 'Lamborghini',
      model: 'Huracan',
      price: 300,
      imageUrls: [
        'assets/images/lamborghini_car_2.webp',
        'assets/images/car_banner.png',
      ],
      rating: 4.9,
      reviewCount: 150,
      description: 'An iconic supercar with breathtaking performance and aggressive Italian styling.',
      seats: 2,
      isFavorite: false,
      owner: const Owner(
        id: 'owner4',
        name: 'Marco Rossi',
        avatarUrl: 'assets/images/user_avatar.png',
        isVerified: true,
      ),
      features: const [
        CarFeature(
          icon: Icons.airline_seat_recline_normal,
          title: 'Capacity',
          value: '2 Seats',
        ),
        CarFeature(
          icon: Icons.speed,
          title: 'Engine Out',
          value: '640 HP',
        ),
        CarFeature(
          icon: Icons.speed_outlined,
          title: 'Max Speed',
          value: '325km/h',
        ),
        CarFeature(
          icon: Icons.auto_mode,
          title: 'Advance',
          value: 'Corsa Mode',
        ),
        CarFeature(
          icon: Icons.local_gas_station,
          title: 'Fuel Tank',
          value: '83 Liters',
        ),
        CarFeature(
          icon: Icons.local_parking,
          title: 'Advance',
          value: 'Lift System',
        ),
      ],
      reviews: const [
        Review(
          id: 'review7',
          authorName: 'James',
          authorAvatarUrl: 'assets/images/user_avatar.png',
          rating: 5.0,
          content: 'A dream come true! The sound of that V10 is incredible.',
        ),
        Review(
          id: 'review8',
          authorName: 'Sophie',
          authorAvatarUrl: 'assets/images/user_avatar.png',
          rating: 4.8,
          content: 'Worth every penny. An unforgettable experience.',
        ),
      ],
    ),
    '5': CarDetail(
      id: '5',
      brand: 'Toyota',
      model: 'Camry',
      price: 50,
      imageUrls: [
        'assets/images/toyota_car_1.jpg',
        'assets/images/toyota_car_2.png',
      ],
      rating: 4.5,
      reviewCount: 200,
      description: 'A reliable and comfortable sedan, perfect for everyday driving and long trips.',
      seats: 5,
      isFavorite: false,
      owner: const Owner(
        id: 'owner5',
        name: 'David Wilson',
        avatarUrl: 'assets/images/user_avatar.png',
        isVerified: true,
      ),
      features: const [
        CarFeature(
          icon: Icons.airline_seat_recline_normal,
          title: 'Capacity',
          value: '5 Seats',
        ),
        CarFeature(
          icon: Icons.speed,
          title: 'Engine Out',
          value: '206 HP',
        ),
        CarFeature(
          icon: Icons.speed_outlined,
          title: 'Max Speed',
          value: '210km/h',
        ),
        CarFeature(
          icon: Icons.auto_mode,
          title: 'Advance',
          value: 'Eco Mode',
        ),
        CarFeature(
          icon: Icons.local_gas_station,
          title: 'Fuel Tank',
          value: '60 Liters',
        ),
        CarFeature(
          icon: Icons.local_parking,
          title: 'Advance',
          value: 'Park Assist',
        ),
      ],
      reviews: const [
        Review(
          id: 'review9',
          authorName: 'Tom',
          authorAvatarUrl: 'assets/images/user_avatar.png',
          rating: 4.5,
          content: 'Perfect for family trips. Very comfortable and fuel efficient.',
        ),
        Review(
          id: 'review10',
          authorName: 'Anna',
          authorAvatarUrl: 'assets/images/user_avatar.png',
          rating: 4.5,
          content: 'Great value for money. Reliable and smooth ride.',
        ),
      ],
    ),
  };

  /// Get car details by ID
  Future<CarDetail> getCarDetails(String carId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    final carDetail = _mockCarDetails[carId];
    if (carDetail != null) {
      return carDetail;
    }
    
    // Return first car as default if ID not found
    return _mockCarDetails.values.first;
  }
}
