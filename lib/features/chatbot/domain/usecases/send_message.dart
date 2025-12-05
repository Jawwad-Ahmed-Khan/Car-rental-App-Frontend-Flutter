import '../entities/chat_message.dart';
import '../repositories/chatbot_repository.dart';

/// Use case for sending a message to the chatbot
class SendMessage {
  final ChatbotRepository repository;

  SendMessage(this.repository);

  Future<ChatMessage> call(String message) async {
    return await repository.sendMessage(message);
  }
}
