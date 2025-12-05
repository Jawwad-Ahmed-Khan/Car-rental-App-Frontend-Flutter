import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_chats.dart';
import '../../domain/usecases/get_stories.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChats getChats;
  final GetStories getStories;

  ChatBloc({required this.getChats, required this.getStories}) : super(ChatInitial()) {
    on<LoadChatsAndStories>(_onLoadChatsAndStories);
  }

  Future<void> _onLoadChatsAndStories(
    LoadChatsAndStories event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());

    final chatsResult = await getChats(NoParams());
    final storiesResult = await getStories(NoParams());

    chatsResult.fold(
      (failure) => emit(const ChatError(message: 'Failed to load chats')),
      (chats) {
        storiesResult.fold(
          (failure) => emit(const ChatError(message: 'Failed to load stories')),
          (stories) => emit(ChatLoaded(chats: chats, stories: stories)),
        );
      },
    );
  }
}
