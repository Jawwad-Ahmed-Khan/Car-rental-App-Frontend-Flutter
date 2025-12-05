import 'package:flutter/material.dart';
import '../../domain/entities/review.dart';

/// Single review list item for vertical display
class ReviewListItem extends StatelessWidget {
  final Review review;

  const ReviewListItem({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD7D7D7)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author info row
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(review.authorAvatarUrl),
                onBackgroundImageError: (_, __) {},
                child: review.authorAvatarUrl.isEmpty
                    ? const Icon(Icons.person, size: 20, color: Colors.grey)
                    : null,
              ),
              const SizedBox(width: 12),
              // Name
              Expanded(
                child: Text(
                  review.authorName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              // Date
              Text(
                review.relativeTime,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF7F7F7F),
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Star rating row
          Row(
            children: List.generate(5, (index) {
              final isFullStar = index < review.rating.floor();
              final isHalfStar =
                  index == review.rating.floor() && review.rating % 1 >= 0.5;

              return Icon(
                isFullStar || isHalfStar ? Icons.star : Icons.star_border,
                color: const Color(0xFFFFA500),
                size: 18,
              );
            }),
          ),
          const SizedBox(height: 12),
          // Review content
          Text(
            review.content,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF7F7F7F),
              height: 1.5,
              fontFamily: 'Roboto',
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
