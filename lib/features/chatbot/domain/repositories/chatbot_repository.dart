import '../entities/chat_message.dart';

/// Repository interface for chatbot operations
abstract class ChatbotRepository {
  /// Send a message and get a response
  Future<ChatMessage> sendMessage(String message);

  /// Get initial greeting messages
  Future<List<ChatMessage>> getInitialMessages();
}
