/// Review entity representing a user review
class Review {
  final String id;
  final String authorName;
  final String authorAvatarUrl;
  final double rating;
  final String content;

  const Review({
    required this.id,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.rating,
    required this.content,
  });
}
