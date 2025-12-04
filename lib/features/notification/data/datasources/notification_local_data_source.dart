import '../../domain/entities/notification.dart';
import '../models/notification_model.dart';

/// Abstract data source for notifications
abstract class NotificationLocalDataSource {
  Future<List<NotificationModel>> getNotifications();
  Future<void> markAsRead(String id);
  Future<void> deleteNotifications(List<String> ids);
}

/// Implementation with mock data matching Figma design
class NotificationLocalDataSourceImpl implements NotificationLocalDataSource {
  // Mutable list to allow modifications
  final List<NotificationModel> _notifications = [
    // Today's notifications
    NotificationModel(
      id: '1',
      title: 'Car Booking Successful',
      message: 'Your car is ready! Check your email for the booking and pickup instructions. Safe travels!',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      type: NotificationType.bookingSuccess,
      isRead: false,
    ),
    NotificationModel(
      id: '2',
      title: 'Payment Notification',
      message: 'Your payment was processed successfully! Enjoy your ride.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      type: NotificationType.payment,
      isRead: false,
    ),
    NotificationModel(
      id: '3',
      title: 'Car Pickup/Drop-off time',
      message: 'Pickup time confirmed! See you at [Time] for your car rental. Drop-off Time Confirmed! Please',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      type: NotificationType.pickupDropoff,
      isRead: true,
    ),
    // Previous (Yesterday) notifications
    NotificationModel(
      id: '4',
      title: 'Late Return Warning',
      message: 'Late Return Alert! Please return the car as soon as possible to avoid extra charges.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      type: NotificationType.lateReturn,
      isRead: true,
    ),
    NotificationModel(
      id: '5',
      title: 'Cancellation Notice',
      message: 'Your Reservation Has Been Canceled or Booking Cancelled Successfully.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      type: NotificationType.cancellation,
      isRead: true,
    ),
    NotificationModel(
      id: '6',
      title: 'Discount Notification',
      message: 'Congratulations! You\'ve unlocked a 10% discount on your next rental.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      type: NotificationType.discount,
      isRead: true,
    ),
  ];

  @override
  Future<List<NotificationModel>> getNotifications() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_notifications);
  }

  @override
  Future<void> markAsRead(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      final notification = _notifications[index];
      _notifications[index] = NotificationModel(
        id: notification.id,
        title: notification.title,
        message: notification.message,
        timestamp: notification.timestamp,
        type: notification.type,
        isRead: true,
        isSelected: notification.isSelected,
      );
    }
  }

  @override
  Future<void> deleteNotifications(List<String> ids) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _notifications.removeWhere((n) => ids.contains(n.id));
  }
}
