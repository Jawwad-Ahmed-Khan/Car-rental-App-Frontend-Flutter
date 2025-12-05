import 'package:flutter/material.dart';
import '../../../home/domain/entities/car.dart';
import '../../../../routes/app_router.dart';

class SearchCarCard extends StatelessWidget {
  final Car car;
  final String transmission;
  final VoidCallback? onFavoritePressed;
  final VoidCallback? onBookPressed;

  const SearchCarCard({
    super.key,
    required this.car,
    this.transmission = '',
    this.onFavoritePressed,
    this.onBookPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouter.carDetails,
          arguments: {'carId': car.id},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car image with favorite button - Flexible to take remaining space
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.network(
                        car.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFFF8F8F8),
                            child: const Center(
                              child: Icon(
                                Icons.directions_car,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onFavoritePressed,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          car.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 14,
                          color: car.isFavorite ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Car details - Fixed content
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Car name
                    Text(
                      car.model,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    // Rating
                    Row(
                      children: [
                        Text(
                          car.rating.toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(Icons.star, size: 12, color: Colors.orange),
                      ],
                    ),
                    const SizedBox(height: 2),
                    // Location
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            car.transmission,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFF7F7F7F),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Price and Book button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '\$${car.price.toInt()}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const TextSpan(
                                text: '/Day',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF7F7F7F),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap:
                              onBookPressed ??
                              () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouter.carDetails,
                                  arguments: {'carId': car.id},
                                );
                              },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF21292B),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Book now',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
