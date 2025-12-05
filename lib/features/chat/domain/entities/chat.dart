import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final String id;
  final String name;
  final String avatarUrl;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;

  const Chat({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isOnline,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        avatarUrl,
        lastMessage,
        time,
        unreadCount,
        isOnline,
      ];
}
