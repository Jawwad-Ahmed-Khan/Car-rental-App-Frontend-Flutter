import '../../domain/entities/notification.dart';

/// Data model for notification with factory constructors
class NotificationModel extends AppNotification {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.message,
    required super.timestamp,
    required super.type,
    super.isRead,
    super.isSelected,
  });

  /// Create from JSON map
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: NotificationType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => NotificationType.bookingSuccess,
      ),
      isRead: json['isRead'] as bool? ?? false,
      isSelected: json['isSelected'] as bool? ?? false,
    );
  }

  /// Convert to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'type': type.name,
      'isRead': isRead,
      'isSelected': isSelected,
    };
  }

  /// Create model from entity
  factory NotificationModel.fromEntity(AppNotification entity) {
    return NotificationModel(
      id: entity.id,
      title: entity.title,
      message: entity.message,
      timestamp: entity.timestamp,
      type: entity.type,
      isRead: entity.isRead,
      isSelected: entity.isSelected,
    );
  }
}
