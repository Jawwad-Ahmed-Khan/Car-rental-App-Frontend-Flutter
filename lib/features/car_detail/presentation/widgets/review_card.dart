import 'package:flutter/material.dart';
import '../../domain/entities/review.dart';

/// Single review card widget
class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD7D7D7)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(review.authorAvatarUrl),
                onBackgroundImageError: (_, __) {},
                child: review.authorAvatarUrl.isEmpty
                    ? const Icon(Icons.person, size: 16, color: Colors.grey)
                    : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  review.authorName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    review.rating.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 14,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review.content,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF7F7F7F),
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
