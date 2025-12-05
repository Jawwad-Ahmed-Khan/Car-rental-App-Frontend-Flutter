import 'package:flutter/material.dart';

/// Card showing car summary with image, name, description, rating
class CarSummaryCard extends StatelessWidget {
  final String carName;
  final String carDescription;
  final String carImageUrl;
  final double rating;
  final int reviewCount;

  const CarSummaryCard({
    super.key,
    required this.carName,
    required this.carDescription,
    required this.carImageUrl,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Car Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              carImageUrl,
              height: 140,
              width: double.infinity,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 140,
                  width: double.infinity,
                  color: const Color(0xFFF8F8F8),
                  child: const Center(
                    child: Icon(
                      Icons.directions_car,
                      size: 60,
                      color: Color(0xFF7F7F7F),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Car Name and Rating Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Car Name
              Expanded(
                child: Text(
                  carName,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
              // Rating
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xFF000000),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.star,
                        size: 18,
                        color: Color(0xFFFFB800),
                      ),
                    ],
                  ),
                  Text(
                    '($reviewCount+Reviews)',
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xFF7F7F7F),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Description
          Text(
            carDescription,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xFF7F7F7F),
            ),
          ),
        ],
      ),
    );
  }
}
