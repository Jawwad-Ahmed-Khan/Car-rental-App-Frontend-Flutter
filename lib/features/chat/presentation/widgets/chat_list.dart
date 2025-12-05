import 'package:flutter/material.dart';
import '../../domain/entities/chat.dart';
import 'chat_list_item.dart';

class ChatList extends StatelessWidget {
  final List<Chat> chats;

  const ChatList({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return ChatListItem(chat: chats[index]);
      },
    );
  }
}
