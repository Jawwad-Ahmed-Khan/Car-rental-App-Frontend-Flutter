import '../repositories/notification_repository.dart';

/// Use case to mark a notification as read
class MarkNotificationRead {
  final NotificationRepository repository;

  MarkNotificationRead(this.repository);

  Future<void> call(String id) async {
    return await repository.markAsRead(id);
  }
}
