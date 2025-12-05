import 'package:flutter/material.dart';
import '../../domain/entities/review.dart';
import 'review_card.dart';

/// Section displaying reviews with header and horizontal scroll list
class ReviewsSection extends StatelessWidget {
  final List<Review> reviews;
  final int totalReviewCount;
  final VoidCallback? onSeeAllPressed;

  const ReviewsSection({
    super.key,
    required this.reviews,
    required this.totalReviewCount,
    this.onSeeAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Review ($totalReviewCount)',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: onSeeAllPressed,
                child: const Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7F7F7F),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        
        // Horizontal scroll list
        SizedBox(
          height: 130,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: reviews.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return ReviewCard(review: reviews[index]);
            },
          ),
        ),
      ],
    );
  }
}
