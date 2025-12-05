import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/chatbot_repository.dart';
import '../datasources/chatbot_local_data_source.dart';

/// Implementation of ChatbotRepository
class ChatbotRepositoryImpl implements ChatbotRepository {
  final ChatbotLocalDataSource localDataSource;

  ChatbotRepositoryImpl({required this.localDataSource});

  @override
  Future<ChatMessage> sendMessage(String message) async {
    return await localDataSource.sendMessage(message);
  }

  @override
  Future<List<ChatMessage>> getInitialMessages() async {
    return await localDataSource.getInitialMessages();
  }
}
