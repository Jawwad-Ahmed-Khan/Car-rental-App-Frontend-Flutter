import 'package:equatable/equatable.dart';
import '../../domain/entities/chat_message.dart';

abstract class ChatbotEvent extends Equatable {
  const ChatbotEvent();

  @override
  List<Object?> get props => [];
}

/// Load initial chatbot messages
class LoadInitialMessages extends ChatbotEvent {}

/// Send a message to the chatbot
class SendMessageEvent extends ChatbotEvent {
  final String message;

  const SendMessageEvent(this.message);

  @override
  List<Object?> get props => [message];
}

/// Add a user message to the chat
class AddUserMessage extends ChatbotEvent {
  final ChatMessage message;

  const AddUserMessage(this.message);

  @override
  List<Object?> get props => [message];
}
