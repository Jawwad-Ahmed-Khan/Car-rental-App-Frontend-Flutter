import '../../domain/entities/chat.dart';

class ChatModel extends Chat {
  const ChatModel({
    required super.id,
    required super.name,
    required super.avatarUrl,
    required super.lastMessage,
    required super.time,
    required super.unreadCount,
    required super.isOnline,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      lastMessage: json['lastMessage'],
      time: json['time'],
      unreadCount: json['unreadCount'],
      isOnline: json['isOnline'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'lastMessage': lastMessage,
      'time': time,
      'unreadCount': unreadCount,
      'isOnline': isOnline,
    };
  }
}
