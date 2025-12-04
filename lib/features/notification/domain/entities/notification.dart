/// Enum representing different notification types in the app
enum NotificationType {
  bookingSuccess,
  payment,
  pickupDropoff,
  lateReturn,
  cancellation,
  discount,
}

/// Notification entity for the domain layer
class AppNotification {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final NotificationType type;
  final bool isRead;
  final bool isSelected;

  const AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    this.isRead = false,
    this.isSelected = false,
  });

  AppNotification copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? timestamp,
    NotificationType? type,
    bool? isRead,
    bool? isSelected,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
