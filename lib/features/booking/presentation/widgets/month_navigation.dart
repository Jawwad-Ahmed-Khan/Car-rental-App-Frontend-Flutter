import 'package:flutter/material.dart';

/// Widget for navigating between months
class MonthNavigation extends StatelessWidget {
  final DateTime displayMonth;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const MonthNavigation({
    super.key,
    required this.displayMonth,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous month button
          GestureDetector(
            onTap: onPreviousMonth,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.chevron_left,
                size: 24,
                color: Colors.black,
              ),
            ),
          ),
          // Month and Year text
          Text(
            '${_getMonthName(displayMonth.month)} ${displayMonth.year}',
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          // Next month button
          GestureDetector(
            onTap: onNextMonth,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.chevron_right,
                size: 24,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
