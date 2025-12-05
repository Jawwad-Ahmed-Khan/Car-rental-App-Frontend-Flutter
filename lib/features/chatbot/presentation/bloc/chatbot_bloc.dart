import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/usecases/send_message.dart';
import '../../domain/usecases/get_initial_messages.dart';
import 'chatbot_event.dart';
import 'chatbot_state.dart';

class ChatbotBloc extends Bloc<ChatbotEvent, ChatbotState> {
  final SendMessage sendMessage;
  final GetInitialMessages getInitialMessages;
  int _messageId = 100;

  ChatbotBloc({
    required this.sendMessage,
    required this.getInitialMessages,
  }) : super(ChatbotInitial()) {
    on<LoadInitialMessages>(_onLoadInitialMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<AddUserMessage>(_onAddUserMessage);
  }

  String _generateId() {
    _messageId++;
    return 'user_msg_$_messageId';
  }

  Future<void> _onLoadInitialMessages(
    LoadInitialMessages event,
    Emitter<ChatbotState> emit,
  ) async {
    emit(ChatbotLoading());
    try {
      final messages = await getInitialMessages();
      emit(ChatbotLoaded(messages: messages));
    } catch (e) {
      emit(ChatbotError(e.toString()));
    }
  }

  Future<void> _onAddUserMessage(
    AddUserMessage event,
    Emitter<ChatbotState> emit,
  ) async {
    if (state is ChatbotLoaded) {
      final currentState = state as ChatbotLoaded;
      final updatedMessages = [...currentState.messages, event.message];
      emit(currentState.copyWith(messages: updatedMessages));
    }
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatbotState> emit,
  ) async {
    if (state is ChatbotLoaded) {
      final currentState = state as ChatbotLoaded;

      // Add user message
      final userMessage = ChatMessage(
        id: _generateId(),
        text: event.message,
        isBot: false,
        timestamp: DateTime.now(),
      );

      final messagesWithUser = [...currentState.messages, userMessage];
      emit(ChatbotLoaded(messages: messagesWithUser, isBotTyping: true));

      try {
        // Get bot response
        final botResponse = await sendMessage(event.message);
        final messagesWithBot = [...messagesWithUser, botResponse];
        emit(ChatbotLoaded(messages: messagesWithBot, isBotTyping: false));
      } catch (e) {
        emit(ChatbotLoaded(messages: messagesWithUser, isBotTyping: false));
      }
    }
  }
}
