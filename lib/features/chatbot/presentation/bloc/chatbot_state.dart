import 'package:equatable/equatable.dart';
import '../../domain/entities/chat_message.dart';

abstract class ChatbotState extends Equatable {
  const ChatbotState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class ChatbotInitial extends ChatbotState {}

/// Loading state
class ChatbotLoading extends ChatbotState {
  final List<ChatMessage> messages;

  const ChatbotLoading({this.messages = const []});

  @override
  List<Object?> get props => [messages];
}

/// Loaded state with messages
class ChatbotLoaded extends ChatbotState {
  final List<ChatMessage> messages;
  final bool isBotTyping;

  const ChatbotLoaded({
    required this.messages,
    this.isBotTyping = false,
  });

  ChatbotLoaded copyWith({
    List<ChatMessage>? messages,
    bool? isBotTyping,
  }) {
    return ChatbotLoaded(
      messages: messages ?? this.messages,
      isBotTyping: isBotTyping ?? this.isBotTyping,
    );
  }

  @override
  List<Object?> get props => [messages, isBotTyping];
}

/// Error state
class ChatbotError extends ChatbotState {
  final String message;

  const ChatbotError(this.message);

  @override
  List<Object?> get props => [message];
}
