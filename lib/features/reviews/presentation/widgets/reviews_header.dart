import 'package:flutter/material.dart';

/// Header widget showing rating and total review count
class ReviewsHeader extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const ReviewsHeader({
    super.key,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Icon(
            Icons.star,
            color: Color(0xFFFFA500),
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            '${rating.toStringAsFixed(1)} Reviews ($reviewCount)',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }
}
