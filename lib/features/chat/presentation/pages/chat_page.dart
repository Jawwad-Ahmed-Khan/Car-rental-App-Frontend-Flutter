import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import '../widgets/chat_app_bar.dart';
import '../widgets/chat_search_bar.dart';
import '../widgets/story_list.dart';
import '../widgets/chat_list.dart';
import '../../data/datasources/chat_local_data_source.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/usecases/get_chats.dart';
import '../../domain/usecases/get_stories.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Manual dependency injection for now if GetIt is not fully set up for this feature
    final chatLocalDataSource = ChatLocalDataSourceImpl();
    final chatRepository = ChatRepositoryImpl(localDataSource: chatLocalDataSource);
    final getChats = GetChats(chatRepository);
    final getStories = GetStories(chatRepository);

    return BlocProvider(
      create: (context) => ChatBloc(
        getChats: getChats,
        getStories: getStories,
      )..add(LoadChatsAndStories()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const ChatAppBar(),
        body: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChatLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ChatSearchBar(),
                    const SizedBox(height: 10),
                    StoryList(stories: state.stories),
                    const SizedBox(height: 10),
                    ChatList(chats: state.chats),
                  ],
                ),
              );
            } else if (state is ChatError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
