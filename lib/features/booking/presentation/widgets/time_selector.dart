import 'package:flutter/material.dart';

/// Widget for selecting start and end time
class TimeSelector extends StatelessWidget {
  final DateTime startTime;
  final DateTime endTime;
  final VoidCallback? onStartTimePressed;
  final VoidCallback? onEndTimePressed;

  const TimeSelector({
    super.key,
    required this.startTime,
    required this.endTime,
    this.onStartTimePressed,
    this.onEndTimePressed,
  });

  String _formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'pm' : 'am';
    return '$hour : $minute  $period';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Start Time Chip
          _buildTimeChip(
            time: startTime,
            isSelected: true,
            onTap: onStartTimePressed,
          ),
          const SizedBox(width: 12),
          // End Time Chip
          _buildTimeChip(
            time: endTime,
            isSelected: false,
            onTap: onEndTimePressed,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeChip({
    required DateTime time,
    required bool isSelected,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF21292B) : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? const Color(0xFF21292B) : const Color(0xFFD7D7D7),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.access_time_outlined,
              size: 18,
              color: isSelected ? Colors.white : const Color(0xFF767676),
            ),
            const SizedBox(width: 8),
            Text(
              _formatTime(time),
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
