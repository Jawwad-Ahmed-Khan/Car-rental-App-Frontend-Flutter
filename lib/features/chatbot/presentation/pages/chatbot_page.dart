import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chatbot_bloc.dart';
import '../bloc/chatbot_event.dart';
import '../bloc/chatbot_state.dart';
import '../widgets/chatbot_app_bar.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/car_recommendation_card.dart';
import '../widgets/chat_message_input.dart';
import '../widgets/typing_indicator.dart';
import '../../data/datasources/chatbot_local_data_source.dart';
import '../../data/repositories/chatbot_repository_impl.dart';
import '../../domain/usecases/send_message.dart';
import '../../domain/usecases/get_initial_messages.dart';
import '../../domain/entities/chat_message.dart';

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Manual dependency injection
    final chatbotLocalDataSource = ChatbotLocalDataSourceImpl();
    final chatbotRepository = ChatbotRepositoryImpl(
      localDataSource: chatbotLocalDataSource,
    );
    final sendMessage = SendMessage(chatbotRepository);
    final getInitialMessages = GetInitialMessages(chatbotRepository);

    return BlocProvider(
      create: (context) => ChatbotBloc(
        sendMessage: sendMessage,
        getInitialMessages: getInitialMessages,
      )..add(LoadInitialMessages()),
      child: const ChatbotPageContent(),
    );
  }
}

class ChatbotPageContent extends StatelessWidget {
  const ChatbotPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ChatbotAppBar(),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: BlocBuilder<ChatbotBloc, ChatbotState>(
              builder: (context, state) {
                if (state is ChatbotLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatbotLoaded) {
                  return _buildMessageList(context, state);
                } else if (state is ChatbotError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          // Message input
          BlocBuilder<ChatbotBloc, ChatbotState>(
            builder: (context, state) {
              final isTyping =
                  state is ChatbotLoaded && state.isBotTyping;
              return ChatMessageInput(
                onSend: (message) {
                  context.read<ChatbotBloc>().add(SendMessageEvent(message));
                },
                isLoading: isTyping,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(BuildContext context, ChatbotLoaded state) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      itemCount: state.messages.length + (state.isBotTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == state.messages.length && state.isBotTyping) {
          return const TypingIndicator();
        }

        final message = state.messages[index];
        if (message.type == ChatMessageType.carRecommendation) {
          return CarRecommendationCard(message: message);
        }
        return ChatMessageBubble(message: message);
      },
    );
  }
}
