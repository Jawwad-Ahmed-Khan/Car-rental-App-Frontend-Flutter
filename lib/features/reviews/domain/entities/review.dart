/// Review entity representing a user review with date
class Review {
  final String id;
  final String authorName;
  final String authorAvatarUrl;
  final double rating;
  final String content;
  final DateTime createdAt;

  const Review({
    required this.id,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.rating,
    required this.content,
    required this.createdAt,
  });

  /// Get relative time string (Today, Yesterday, 2 Weeks ago, etc.)
  String get relativeTime {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 14) {
      return '1 Week ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks Weeks ago';
    } else if (difference.inDays < 60) {
      return '1 Month ago';
    } else {
      final months = (difference.inDays / 30).floor();
      return '$months Months ago';
    }
  }
}
