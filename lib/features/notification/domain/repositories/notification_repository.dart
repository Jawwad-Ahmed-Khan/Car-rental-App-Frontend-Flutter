import '../entities/notification.dart';

/// Abstract repository for notification operations
abstract class NotificationRepository {
  /// Fetches all notifications
  Future<List<AppNotification>> getNotifications();

  /// Marks a notification as read
  Future<void> markAsRead(String id);

  /// Deletes notifications by their IDs
  Future<void> deleteNotifications(List<String> ids);
}
