import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

/// Use case to get all notifications
class GetNotifications {
  final NotificationRepository repository;

  GetNotifications(this.repository);

  Future<List<AppNotification>> call() async {
    return await repository.getNotifications();
  }
}
