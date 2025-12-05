import 'package:flutter/material.dart';

/// Section displaying car model, rating, and description
class CarInfoSection extends StatelessWidget {
  final String model;
  final double rating;
  final int reviewCount;
  final String description;

  const CarInfoSection({
    super.key,
    required this.model,
    required this.rating,
    required this.reviewCount,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  model,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        rating.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '($reviewCount+Reviews)',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF7F7F7F),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF7F7F7F),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
