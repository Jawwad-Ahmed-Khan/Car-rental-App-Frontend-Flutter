import 'package:flutter/material.dart';
import '../../data/datasources/notification_local_data_source.dart';
import '../../data/repositories/notification_repository_impl.dart';
import '../../domain/entities/notification.dart';
import '../../domain/usecases/get_notifications.dart';
import '../widgets/notification_app_bar.dart';
import '../widgets/notification_selection_bar.dart';
import '../widgets/notification_item.dart';

/// Main notification page
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late final GetNotifications _getNotifications;
  late final NotificationLocalDataSourceImpl _dataSource;
  
  List<AppNotification> _notifications = [];
  bool _isLoading = true;
  bool _isSelectionMode = false;
  Set<String> _selectedIds = {};

  @override
  void initState() {
    super.initState();
    _dataSource = NotificationLocalDataSourceImpl();
    final repository = NotificationRepositoryImpl(localDataSource: _dataSource);
    _getNotifications = GetNotifications(repository);
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() => _isLoading = true);
    final notifications = await _getNotifications();
    setState(() {
      _notifications = notifications;
      _isLoading = false;
    });
  }

  void _toggleSelectAll() {
    setState(() {
      if (_selectedIds.length == _notifications.length) {
        // Deselect all
        _selectedIds.clear();
        _isSelectionMode = false;
      } else {
        // Select all
        _selectedIds = _notifications.map((n) => n.id).toSet();
        _isSelectionMode = true;
      }
      _updateNotificationSelections();
    });
  }

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
        if (_selectedIds.isEmpty) {
          _isSelectionMode = false;
        }
      } else {
        _selectedIds.add(id);
        _isSelectionMode = true;
      }
      _updateNotificationSelections();
    });
  }

  void _updateNotificationSelections() {
    _notifications = _notifications.map((n) {
      return n.copyWith(isSelected: _selectedIds.contains(n.id));
    }).toList();
  }

  Future<void> _deleteSelected() async {
    if (_selectedIds.isEmpty) return;
    
    await _dataSource.deleteNotifications(_selectedIds.toList());
    setState(() {
      _notifications.removeWhere((n) => _selectedIds.contains(n.id));
      _selectedIds.clear();
      _isSelectionMode = false;
    });
  }

  // Group notifications by date
  Map<String, List<AppNotification>> _groupNotifications() {
    final Map<String, List<AppNotification>> grouped = {
      'Today': [],
      'Previous': [],
    };

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    for (final notification in _notifications) {
      final notificationDate = DateTime(
        notification.timestamp.year,
        notification.timestamp.month,
        notification.timestamp.day,
      );

      if (notificationDate == today) {
        grouped['Today']!.add(notification);
      } else {
        grouped['Previous']!.add(notification);
      }
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final groupedNotifications = _groupNotifications();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            // App bar
            const NotificationAppBar(),
            // Divider
            const Divider(color: Color(0xFFD7D7D7), height: 1),
            // Selection bar
            NotificationSelectionBar(
              isAllSelected: _selectedIds.length == _notifications.length && 
                             _notifications.isNotEmpty,
              selectedCount: _selectedIds.length,
              onAllToggle: _toggleSelectAll,
              onDelete: _deleteSelected,
            ),
            // Content
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: _loadNotifications,
                      child: ListView(
                        children: [
                          // Today section
                          if (groupedNotifications['Today']!.isNotEmpty) ...[
                            _buildSectionHeader('Today'),
                            ...groupedNotifications['Today']!.map(
                              (notification) => NotificationItem(
                                notification: notification,
                                isSelectionMode: _isSelectionMode,
                                onTap: () => _handleNotificationTap(notification),
                                onSelect: () => _toggleSelection(notification.id),
                              ),
                            ),
                          ],
                          // Previous section
                          if (groupedNotifications['Previous']!.isNotEmpty) ...[
                            _buildSectionHeader('Previous'),
                            ...groupedNotifications['Previous']!.map(
                              (notification) => NotificationItem(
                                notification: notification,
                                isSelectionMode: _isSelectionMode,
                                onTap: () => _handleNotificationTap(notification),
                                onSelect: () => _toggleSelection(notification.id),
                              ),
                            ),
                          ],
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  void _handleNotificationTap(AppNotification notification) {
    // Mark as read and handle navigation based on type
    _dataSource.markAsRead(notification.id);
    setState(() {
      final index = _notifications.indexWhere((n) => n.id == notification.id);
      if (index != -1) {
        _notifications[index] = notification.copyWith(isRead: true);
      }
    });
    
    // TODO: Navigate based on notification type
    debugPrint('Tapped notification: ${notification.title}');
  }
}
