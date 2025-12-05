/// Represents a chat message in the chatbot conversation
class ChatMessage {
  final String id;
  final String text;
  final bool isBot;
  final DateTime timestamp;
  final ChatMessageType type;
  final CarRecommendation? carRecommendation;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.isBot,
    required this.timestamp,
    this.type = ChatMessageType.text,
    this.carRecommendation,
  });
}

enum ChatMessageType {
  text,
  carRecommendation,
}

/// Represents a car recommendation shown in chat
class CarRecommendation {
  final String name;
  final String imageUrl;
  final double rating;
  final String location;
  final int seats;
  final double pricePerDay;
  final String? alsoAvailable;
  final String? alsoAvailableImage;
  final double? alsoAvailableRating;

  const CarRecommendation({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.location,
    required this.seats,
    required this.pricePerDay,
    this.alsoAvailable,
    this.alsoAvailableImage,
    this.alsoAvailableRating,
  });
}
