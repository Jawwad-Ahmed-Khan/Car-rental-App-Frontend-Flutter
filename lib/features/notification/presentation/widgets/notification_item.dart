import 'package:flutter/material.dart';
import '../../domain/entities/notification.dart';

/// Notification list item widget
class NotificationItem extends StatelessWidget {
  final AppNotification notification;
  final bool isSelectionMode;
  final VoidCallback onTap;
  final VoidCallback onSelect;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.isSelectionMode,
    required this.onTap,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isSelectionMode ? onSelect : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: notification.isSelected 
              ? const Color(0xFFE8E8E8) 
              : Colors.transparent,
          border: const Border(
            bottom: BorderSide(color: Color(0xFFD7D7D7), width: 0.5),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selection checkbox (shown when in selection mode)
            if (isSelectionMode) ...[
              Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.only(right: 12, top: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: notification.isSelected 
                      ? const Color(0xFF21292B) 
                      : Colors.transparent,
                  border: Border.all(
                    color: notification.isSelected 
                        ? const Color(0xFF21292B) 
                        : const Color(0xFFD7D7D7),
                    width: 2,
                  ),
                ),
                child: notification.isSelected
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
            ],
            // Icon container
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFD7D7D7)),
              ),
              child: Icon(
                _getNotificationIcon(notification.type),
                size: 22,
                color: const Color(0xFF767676),
              ),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Expanded(
                        child: Text(
                          notification.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // Timestamp and unread indicator
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _formatTimestamp(notification.timestamp),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF7F7F7F),
                            ),
                          ),
                          if (!notification.isRead) ...[
                            const SizedBox(width: 6),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF3B82F6),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Message
                  Text(
                    notification.message,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF7F7F7F),
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.bookingSuccess:
        return Icons.star_outline;
      case NotificationType.payment:
        return Icons.receipt_long_outlined;
      case NotificationType.pickupDropoff:
        return Icons.directions_car_outlined;
      case NotificationType.lateReturn:
        return Icons.warning_amber_outlined;
      case NotificationType.cancellation:
        return Icons.content_paste_outlined;
      case NotificationType.discount:
        return Icons.card_giftcard_outlined;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays == 0) {
      // Today - show time
      final hour = timestamp.hour;
      final minute = timestamp.minute.toString().padLeft(2, '0');
      final period = hour >= 12 ? 'pm' : 'am';
      final hour12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
      return '$hour12:$minute $period';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}
