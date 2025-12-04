import '../../domain/entities/notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_local_data_source.dart';

/// Implementation of NotificationRepository using local data source
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationLocalDataSource localDataSource;

  NotificationRepositoryImpl({required this.localDataSource});

  @override
  Future<List<AppNotification>> getNotifications() async {
    return await localDataSource.getNotifications();
  }

  @override
  Future<void> markAsRead(String id) async {
    await localDataSource.markAsRead(id);
  }

  @override
  Future<void> deleteNotifications(List<String> ids) async {
    await localDataSource.deleteNotifications(ids);
  }
}
