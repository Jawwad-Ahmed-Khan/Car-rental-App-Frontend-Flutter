import '../entities/chat_message.dart';
import '../repositories/chatbot_repository.dart';

/// Use case for getting initial chatbot messages
class GetInitialMessages {
  final ChatbotRepository repository;

  GetInitialMessages(this.repository);

  Future<List<ChatMessage>> call() async {
    return await repository.getInitialMessages();
  }
}
