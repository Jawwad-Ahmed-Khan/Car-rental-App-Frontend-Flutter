import '../../domain/entities/chat_message.dart';

/// Local data source for chatbot with mock responses
abstract class ChatbotLocalDataSource {
  Future<ChatMessage> sendMessage(String message);
  Future<List<ChatMessage>> getInitialMessages();
}

class ChatbotLocalDataSourceImpl implements ChatbotLocalDataSource {
  int _messageId = 0;

  String _generateId() {
    _messageId++;
    return 'msg_$_messageId';
  }

  @override
  Future<List<ChatMessage>> getInitialMessages() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      ChatMessage(
        id: _generateId(),
        text: 'Hello! How can I help you find your perfect car today?',
        isBot: true,
        timestamp: DateTime.now(),
      ),
    ];
  }

  @override
  Future<ChatMessage> sendMessage(String message) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final lowerMessage = message.toLowerCase();

    // Check for car-related queries
    if (lowerMessage.contains('nano banana') ||
        lowerMessage.contains('banana pro') ||
        lowerMessage.contains('show me')) {
      return ChatMessage(
        id: _generateId(),
        text: 'Great choice! Here is the Nano Banana Pro.',
        isBot: true,
        timestamp: DateTime.now(),
        type: ChatMessageType.carRecommendation,
        carRecommendation: const CarRecommendation(
          name: 'Nano Banana Pro',
          imageUrl: 'assets/images/cars/lamborghini.png',
          rating: 5.0,
          location: 'San Francisco, CA',
          seats: 2,
          pricePerDay: 150,
          alsoAvailable: 'Tesla Model S',
          alsoAvailableImage: 'assets/images/cars/tesla.png',
          alsoAvailableRating: 5.0,
        ),
      );
    } else if (lowerMessage.contains('tesla') ||
        lowerMessage.contains('electric')) {
      return ChatMessage(
        id: _generateId(),
        text: 'Here\'s a great electric option for you!',
        isBot: true,
        timestamp: DateTime.now(),
        type: ChatMessageType.carRecommendation,
        carRecommendation: const CarRecommendation(
          name: 'Tesla Model S',
          imageUrl: 'assets/images/cars/tesla.png',
          rating: 5.0,
          location: 'San Francisco, CA',
          seats: 5,
          pricePerDay: 200,
        ),
      );
    } else if (lowerMessage.contains('suv') ||
        lowerMessage.contains('family')) {
      return ChatMessage(
        id: _generateId(),
        text: 'Perfect for family trips! Check out this SUV.',
        isBot: true,
        timestamp: DateTime.now(),
        type: ChatMessageType.carRecommendation,
        carRecommendation: const CarRecommendation(
          name: 'Range Rover Sport',
          imageUrl: 'assets/images/cars/range_rover.png',
          rating: 4.8,
          location: 'Los Angeles, CA',
          seats: 7,
          pricePerDay: 180,
        ),
      );
    } else if (lowerMessage.contains('cheap') ||
        lowerMessage.contains('budget')) {
      return ChatMessage(
        id: _generateId(),
        text: 'Here\'s a budget-friendly option!',
        isBot: true,
        timestamp: DateTime.now(),
        type: ChatMessageType.carRecommendation,
        carRecommendation: const CarRecommendation(
          name: 'Toyota Camry',
          imageUrl: 'assets/images/cars/camry.png',
          rating: 4.5,
          location: 'New York, NY',
          seats: 5,
          pricePerDay: 75,
        ),
      );
    } else if (lowerMessage.contains('hello') ||
        lowerMessage.contains('hi') ||
        lowerMessage.contains('hey')) {
      return ChatMessage(
        id: _generateId(),
        text: 'Hello! I\'m Qent Assistant. How can I help you find your perfect car today?',
        isBot: true,
        timestamp: DateTime.now(),
      );
    } else if (lowerMessage.contains('thank')) {
      return ChatMessage(
        id: _generateId(),
        text: 'You\'re welcome! Is there anything else I can help you with?',
        isBot: true,
        timestamp: DateTime.now(),
      );
    } else if (lowerMessage.contains('recommendation') ||
        lowerMessage.contains('suggest')) {
      return ChatMessage(
        id: _generateId(),
        text: 'I\'d be happy to recommend some cars! What type are you looking for? (SUV, sports car, electric, budget-friendly)',
        isBot: true,
        timestamp: DateTime.now(),
      );
    } else {
      return ChatMessage(
        id: _generateId(),
        text: 'I can help you find the perfect car! Try asking about specific models like "Show me the Nano Banana Pro" or car types like "SUV", "electric", or "budget-friendly".',
        isBot: true,
        timestamp: DateTime.now(),
      );
    }
  }
}
